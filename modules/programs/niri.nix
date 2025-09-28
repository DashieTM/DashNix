{
  mkDashDefault,
  config,
  lib,
  options,
  pkgs,
  ...
}: let
  browserName =
    if (builtins.isString config.mods.homePackages.browser)
    then config.mods.homePackages.browser
    else if config.mods.homePackages.browser ? meta && config.mods.homePackages.browser.meta ? mainProgram
    then config.mods.homePackages.browser.meta.mainProgram
    else config.mods.homePackages.browser.pname;
in {
  options.mods.niri = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = ''
        Enable Niri
      '';
    };
  };

  config = lib.mkIf config.mods.niri.enable (
    lib.optionalAttrs (options ? wayland.windowManager.hyprland) {
      # TODO deduplicate and abstract away base window management config
      # install Niri related packages
      home.packages = with pkgs; [
        xorg.xprop
        grim
        slurp
        satty
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        kdePackages.xdg-desktop-portal-kde
        xdg-desktop-portal-shana
        copyq
        wl-clipboard

        niri
        xwayland-satellite
      ];

      xdg.configFile."niri/config.kdl" = let
        mkNiriMod = mods:
          builtins.map (mod:
            if mod == "Mod"
            then config.mods.wm.modKey + "+"
            else "${mod}" + "+")
          mods
          |> lib.strings.concatStringsSep "";
        mkNiriArg = args:
          if args != []
          then "\"${(lib.strings.concatStringsSep " " args)}\""
          else "";
        mkNiriCommand = cmd: args:
          if cmd == "quit"
          then "quit;"
          else if cmd == "killActive"
          then "close-window;"
          else if cmd == "moveFocusTop"
          then "focus-window-up;"
          else if cmd == "moveWindowRight"
          then "move-column-right-or-to-monitor-right;"
          else if cmd == "moveWindowDown"
          then "move-window-down;"
          else if cmd == "moveWindowLeft"
          then "move-column-left-or-to-monitor-left;"
          else if cmd == "moveWindowUp"
          then "move-window-up;"
          else if cmd == "moveFocusUp"
          then "focus-window-up;"
          else if cmd == "moveFocusRight"
          then "focus-column-or-monitor-right;"
          else if cmd == "moveFocusDown"
          then "focus-window-down;"
          else if cmd == "moveFocusLeft"
          then "focus-column-or-monitor-left;"
          else if cmd == "spawn"
          then "spawn" + " " + mkNiriArg args + ";"
          else if cmd == "spawn-sh"
          then "spawn-sh" + " " + mkNiriArg args + ";"
          else cmd + " " + mkNiriArg args + ";";

        mkNiriBinds = cfg:
          ''            binds {
          ''
          + ((builtins.map (
              bind:
              /*
              kdl
              */
              ''
                ${mkNiriMod bind.modKeys}${bind.key} ${
                  if bind.meta.niri.desc != ""
                  then "hotkey-overlay-title=\"" + bind.meta.niri.desc + "\""
                  else ""
                } ${
                  if bind.meta.niri.repeat
                  then "repeat=true"
                  else "repeat=false"
                } ${
                  if bind.meta.niri.allowInhibit
                  then "allow-inhibiting=true"
                  else "allow-inhibiting=false"
                } { ${mkNiriCommand bind.command bind.args} }
              ''
            ))
            cfg.mods.wm.binds
            |> lib.strings.concatLines)
          + ''
            }'';
        mkNiriMonitors = cfg:
          (builtins.map (
              monitor:
              # TODO vrr
              /*
              kdl
              */
              ''
                output "${monitor.name}" {
                    mode "${builtins.toString monitor.resolutionX}x${builtins.toString monitor.resolutionY}@${builtins.toString monitor.refreshrate}"
                    scale ${builtins.toString monitor.scale}
                    transform "${
                  if (monitor.transform == "0")
                  then "normal"
                  else monitor.transform
                }"
                    position x=${builtins.toString monitor.positionX} y=${builtins.toString monitor.positionY}
                }
              ''
            )
            cfg.mods.wm.monitors)
          |> lib.strings.concatLines;
      in {
        text =
          /*
          kdl
          */
          ''
            input {
                keyboard {
                    xkb {
                        layout "enIntUmlaut"
                    }
                    repeat-delay 200
                    repeat-rate 25
                    numlock
                }

                touchpad {
                    tap
                    natural-scroll
                }

                mouse {
                    accel-speed 0.2
                    accel-profile "flat"
                }
                focus-follows-mouse max-scroll-amount="25%"
            }

            layout {
                // Set gaps around windows in logical pixels.
                gaps 10
                center-focused-column "never"
                always-center-single-column

                preset-column-widths {
                    proportion 0.33333
                    proportion 0.5
                    proportion 1.0
                }

                default-column-width { proportion 0.5; }
                // You can change how the focus ring looks.
                focus-ring {
                    width 3
                    inactive-color "#505050"
                    active-gradient from="#ff0000" to="#0000ff" angle=45
                }

                border {
                    off
                }

                // You can enable drop shadows for windows.
                shadow {
                    // Uncomment the next line to enable shadows.
                    on

                    // By default, the shadow draws only around its window, and not behind it.
                    // Uncomment this setting to make the shadow draw behind its window.
                    //
                    // Note that niri has no way of knowing about the CSD window corner
                    // radius. It has to assume that windows have square corners, leading to
                    // shadow artifacts inside the CSD rounded corners. This setting fixes
                    // those artifacts.
                    //
                    // However, instead you may want to set prefer-no-csd and/or
                    // geometry-corner-radius. Then, niri will know the corner radius and
                    // draw the shadow correctly, without having to draw it behind the
                    // window. These will also remove client-side shadows if the window
                    // draws any.
                    //
                    // draw-behind-window true

                    // You can change how shadows look. The values below are in logical
                    // pixels and match the CSS box-shadow properties.

                    // Softness controls the shadow blur radius.
                    softness 30

                    // Spread expands the shadow.
                    spread 5

                    // Offset moves the shadow relative to the window.
                    offset x=0 y=5

                    // You can also change the shadow color and opacity.
                    color "#0007"
                }
            }

            // Autostart
            spawn-at-startup "ironbar"
            spawn-at-startup "oxinoti"
            spawn-at-startup "oxipaste_daemon"

            // To run a shell command (with variables, pipes, etc.), use spawn-sh-at-startup:
            // spawn-sh-at-startup "qs -c ~/source/qs/MyAwesomeShell"

            hotkey-overlay {
                skip-at-startup
            }

            // Uncomment this line to ask the clients to omit their client-side decorations if possible.
            // If the client will specifically ask for CSD, the request will be honored.
            // Additionally, clients will be informed that they are tiled, removing some client-side rounded corners.
            // This option will also fix border/focus ring drawing behind some semitransparent windows.
            // After enabling or disabling this, you need to restart the apps for this to take effect.
            prefer-no-csd

            // You can change the path where screenshots are saved.
            // A ~ at the front will be expanded to the home directory.
            // The path is formatted with strftime(3) to give you the screenshot date and time.
            screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

            // You can also set this to null to disable saving screenshots to disk.
            // screenshot-path null

            // Animation settings.
            // The wiki explains how to configure individual animations:
            // https://yalter.github.io/niri/Configuration:-Animations
            animations {
                // Uncomment to turn off all animations.
                // off

                // Slow down all animations by this factor. Values below 1 speed them up instead.
                // slowdown 3.0
            }

            // Block screencapture
            window-rule {
                match app-id=r#"^org\.keepassxc\.KeePassXC$"#
                match app-id=r#"^org\.gnome\.World\.Secrets$"#

                block-out-from "screen-capture"
            }

            window-rule {
                match app-id=r#"^nheko$"#
                open-on-workspace "3"
                open-maximized true
            }

            window-rule {
                match app-id=r#"^vesktop$"#
                open-on-workspace "1"
                open-maximized true
            }

            window-rule {
                match app-id=r#"^steam$"#
                open-on-workspace "0"
            }

            // General rules
            window-rule {
                geometry-corner-radius 12
                clip-to-geometry true
            }


            //// binds {
            //    // Keys consist of modifiers separated by + signs, followed by an XKB key name
            //    // in the end. To find an XKB name for a particular key, you may use a program
            //    // like wev.
            //    //
            //    // "Mod" is a special modifier equal to Super when running on a TTY, and to Alt
            //    // when running as a winit window.
            //    //
            //    // Most actions that you can bind here can also be invoked programmatically with
            //    // `niri msg action do-something`.

            //    // Mod-Shift-/, which is usually the same as Mod-?,
            //    // shows a list of important hotkeys.
            //    Mod+Shift+Slash { show-hotkey-overlay; }

            //    // Suggested binds for running programs: terminal, app launcher, screen locker.
            //    Mod+T hotkey-overlay-title="Open a Terminal: alacritty" { spawn "kitty"; }
            //    Mod+R hotkey-overlay-title="Run an Application: fuzzel" { spawn "oxirun"; }
            //    Super+Shift+L hotkey-overlay-title="Lock the Screen: hyprlock" { spawn "hyprlock"; }
            //    Mod+F hotkey-overlay-title="Browser: Zen" { spawn "zen"; }
            //    Mod+G hotkey-overlay-title="Run oxicalc" { spawn "oxicalc"; }
            //    Mod+A hotkey-overlay-title="Run Clipboard manager" { spawn "oxipaste"; }
            //    Mod+D hotkey-overlay-title="Run Shutdown window" { spawn "oxishut"; }
            //    Mod+M hotkey-overlay-title="Run Notification Center" { spawn "oxidash"; }
            //    Mod+S hotkey-overlay-title="Screenshot" {spawn-sh "grim -g \"$(slurp)\" - | wl-copy";}
            //    Super+S hotkey-overlay-title="Screenshot" {spawn-sh "grim -g \"$(slurp)\" - | wl-copy";}
            //    Super+Shift+S hotkey-overlay-title="Screenshot" {spawn-sh "grim -g \"$(slurp)\" - | satty -f -";}
            //    Super+Shift+Alt+S { screenshot-window; }

            //    XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"; }
            //    XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
            //    XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
            //    XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
            //    XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
            //    XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }

            //    // Mod+W repeat=false { toggle-overview; }
            //    Mod+Q repeat=false { close-window; }

            //    Mod+Left  { move-column-left-or-to-monitor-left; }
            //    Mod+Down  { move-window-down; }
            //    Mod+Up    { move-window-up; }
            //    Mod+Right { move-column-right-or-to-monitor-right; }
            //    Mod+J     { focus-column-or-monitor-left; }
            //    Mod+K     { focus-window-down; }
            //    Mod+L     { focus-window-up; }
            //    Mod+semicolon     { focus-column-or-monitor-right; }

            //    Mod+Home { focus-column-first; }
            //    Mod+End  { focus-column-last; }
            //    Mod+Ctrl+Home { move-column-to-first; }
            //    Mod+Ctrl+End  { move-column-to-last; }

            //    Mod+Shift+Left  { focus-monitor-left; }
            //    Mod+Shift+Down  { focus-monitor-down; }
            //    Mod+Shift+Up    { focus-monitor-up; }
            //    Mod+Shift+Right { focus-monitor-right; }
            //    Mod+Shift+H     { focus-monitor-left; }
            //    Mod+Shift+J     { focus-monitor-down; }
            //    Mod+Shift+K     { focus-monitor-up; }
            //    Mod+Shift+L     { focus-monitor-right; }

            //    Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
            //    Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
            //    Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
            //    Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
            //    Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
            //    Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
            //    Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
            //    Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

            //    // Alternatively, there are commands to move just a single window:
            //    // Mod+Shift+Ctrl+Left  { move-window-to-monitor-left; }
            //    // ...

            //    // And you can also move a whole workspace to another monitor:
            //    // Mod+Shift+Ctrl+Left  { move-workspace-to-monitor-left; }
            //    // ...

            //    Mod+Page_Down      { focus-workspace-down; }
            //    Mod+Page_Up        { focus-workspace-up; }
            //    Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
            //    Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
            //    Mod+Ctrl+U         { move-column-to-workspace-down; }
            //    Mod+Ctrl+I         { move-column-to-workspace-up; }

            //    // Alternatively, there are commands to move just a single window:
            //    // Mod+Ctrl+Page_Down { move-window-to-workspace-down; }
            //    // ...

            //    Mod+Shift+Page_Down { move-workspace-down; }
            //    Mod+Shift+Page_Up   { move-workspace-up; }
            //    Mod+Shift+U         { move-workspace-down; }
            //    Mod+Shift+I         { move-workspace-up; }

            //    // You can bind mouse wheel scroll ticks using the following syntax.
            //    // These binds will change direction based on the natural-scroll setting.
            //    //
            //    // To avoid scrolling through workspaces really fast, you can use
            //    // the cooldown-ms property. The bind will be rate-limited to this value.
            //    // You can set a cooldown on any bind, but it's most useful for the wheel.
            //    Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
            //    Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
            //    Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
            //    Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

            //    Mod+WheelScrollRight      { focus-column-right; }
            //    Mod+WheelScrollLeft       { focus-column-left; }
            //    Mod+Ctrl+WheelScrollRight { move-column-right; }
            //    Mod+Ctrl+WheelScrollLeft  { move-column-left; }

            //    // Usually scrolling up and down with Shift in applications results in
            //    // horizontal scrolling; these binds replicate that.
            //    Mod+Shift+WheelScrollDown      { focus-column-right; }
            //    Mod+Shift+WheelScrollUp        { focus-column-left; }
            //    Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
            //    Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

            //    // Similarly, you can bind touchpad scroll "ticks".
            //    // Touchpad scrolling is continuous, so for these binds it is split into
            //    // discrete intervals.
            //    // These binds are also affected by touchpad's natural-scroll, so these
            //    // example binds are "inverted", since we have natural-scroll enabled for
            //    // touchpads by default.
            //    // Mod+TouchpadScrollDown { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02+"; }
            //    // Mod+TouchpadScrollUp   { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02-"; }

            //    // You can refer to workspaces by index. However, keep in mind that
            //    // niri is a dynamic workspace system, so these commands are kind of
            //    // "best effort". Trying to refer to a workspace index bigger than
            //    // the current workspace count will instead refer to the bottommost
            //    // (empty) workspace.
            //    //
            //    // For example, with 2 workspaces + 1 empty, indices 3, 4, 5 and so on
            //    // will all refer to the 3rd workspace.
            //    Mod+1 { focus-workspace "1"; }
            //    Mod+2 { focus-workspace "2"; }
            //    Mod+3 { focus-workspace "3"; }
            //    Mod+4 { focus-workspace "4"; }
            //    Mod+5 { focus-workspace "5"; }
            //    Mod+6 { focus-workspace "6"; }
            //    Mod+7 { focus-workspace "7"; }
            //    Mod+8 { focus-workspace "8"; }
            //    Mod+9 { focus-workspace "9"; }
            //    Mod+0 { focus-workspace "0"; }
            //    Mod+Alt+1 { move-window-to-workspace "1"; }
            //    Mod+Alt+2 { move-window-to-workspace "2"; }
            //    Mod+Alt+3 { move-window-to-workspace "3"; }
            //    Mod+Alt+4 { move-window-to-workspace "4"; }
            //    Mod+Alt+5 { move-window-to-workspace "5"; }
            //    Mod+Alt+6 { move-window-to-workspace "6"; }
            //    Mod+Alt+7 { move-window-to-workspace "7"; }
            //    Mod+Alt+8 { move-window-to-workspace "8"; }
            //    Mod+Alt+9 { move-window-to-workspace "9"; }
            //    Mod+Alt+0 { move-window-to-workspace "0"; }
            //    Mod+Ctrl+1 { move-column-to-workspace "1"; }
            //    Mod+Ctrl+2 { move-column-to-workspace "2"; }
            //    Mod+Ctrl+3 { move-column-to-workspace "3"; }
            //    Mod+Ctrl+4 { move-column-to-workspace "4"; }
            //    Mod+Ctrl+5 { move-column-to-workspace "5"; }
            //    Mod+Ctrl+6 { move-column-to-workspace "6"; }
            //    Mod+Ctrl+7 { move-column-to-workspace "7"; }
            //    Mod+Ctrl+8 { move-column-to-workspace "8"; }
            //    Mod+Ctrl+9 { move-column-to-workspace "9"; }
            //    Mod+Ctrl+0 { move-column-to-workspace "0"; }

            //    Mod+Tab { focus-workspace-previous; }

            //    // The following binds move the focused window in and out of a column.
            //    // If the window is alone, they will consume it into the nearby column to the side.
            //    // If the window is already in a column, they will expel it out.
            //    Mod+BracketLeft  { consume-or-expel-window-left; }
            //    Mod+BracketRight { consume-or-expel-window-right; }

            //    // Consume one window from the right to the bottom of the focused column.
            //    Mod+Comma  { consume-window-into-column; }
            //    // Expel the bottom window from the focused column to the right.
            //    Mod+Period { expel-window-from-column; }

            //    Mod+Y { switch-preset-column-width; }
            //    // Cycling through the presets in reverse order is also possible.
            //    // Mod+R { switch-preset-column-width-back; }
            //    Mod+Shift+R { switch-preset-window-height; }
            //    Mod+Ctrl+R { reset-window-height; }
            //    Mod+B { fullscreen-window; }

            //    // Expand the focused column to space not taken up by other fully visible columns.
            //    // Makes the column "fill the rest of the space".
            //    Mod+Ctrl+F { expand-column-to-available-width; }

            //    Mod+C { center-column; }

            //    // Center all fully visible columns on screen.
            //    Mod+Ctrl+C { center-visible-columns; }

            //    // Finer width adjustments.
            //    // This command can also:
            //    // * set width in pixels: "1000"
            //    // * adjust width in pixels: "-5" or "+5"
            //    // * set width as a percentage of screen width: "25%"
            //    // * adjust width as a percentage of screen width: "-10%" or "+10%"
            //    // Pixel sizes use logical, or scaled, pixels. I.e. on an output with scale 2.0,
            //    // set-column-width "100" will make the column occupy 200 physical screen pixels.
            //    Mod+U { set-column-width "-10%"; }
            //    Mod+P { set-column-width "+10%"; }
            //    Mod+O { set-column-width "50%"; }

            //    // Finer height adjustments when in column with other windows.
            //    Mod+Shift+Minus { set-window-height "-10%"; }
            //    Mod+Shift+Equal { set-window-height "+10%"; }

            //    // Move the focused window between the floating and the tiling layout.
            //    Mod+V       { toggle-window-floating; }
            //    Mod+Shift+V { switch-focus-between-floating-and-tiling; }

            //    // Toggle tabbed column display mode.
            //    // Windows in this column will appear as vertical tabs,
            //    // rather than stacked on top of each other.
            //    // Mod+W { toggle-column-tabbed-display; }

            //    Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }
            //    Mod+Shift+M { quit; }
            //}

            workspace "1" {
                    open-on-output "DP-2"
            }

            workspace "2" {
                    open-on-output "DP-1"
            }

            workspace "3" {
                    open-on-output "DP-3"
            }

            workspace "4" {
                    open-on-output "DP-1"
            }

            workspace "5" {
                    open-on-output "DP-2"
            }

            workspace "6" {
                    open-on-output "DP-1"
            }

            workspace "7" {
                    open-on-output "DP-1"
            }

            workspace "8" {
                    open-on-output "DP-1"
            }

            workspace "9" {
                    open-on-output "DP-1"
            }

            workspace "0" {
                    open-on-output "DP-1"
            }
          ''
          + mkNiriMonitors config
          + mkNiriBinds config;
      };
    }
  );
}
