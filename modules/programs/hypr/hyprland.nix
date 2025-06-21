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
  options.mods.hypr.hyprland = {
    enable = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = ''
        Enable Hyprland
      '';
    };
    defaultMonitor = lib.mkOption {
      default = "";
      example = "eDP-1";
      type = lib.types.str;
      description = ''
        main monitor
      '';
    };
    defaultMonitorMode = lib.mkOption {
      default = "";
      example = "3440x1440@180";
      type = lib.types.str;
      description = ''
        main monitor mode: width x height @ refreshrate
      '';
    };
    defaultMonitorScale = lib.mkOption {
      default = "1";
      example = "1.5";
      type = lib.types.str;
      description = ''
        main monitor scaling
      '';
    };
    monitor = lib.mkOption {
      default = [
        # main monitor
        "${config.mods.hypr.hyprland.defaultMonitor},${config.mods.hypr.hyprland.defaultMonitorMode},0x0,${config.mods.hypr.hyprland.defaultMonitorScale}"
        # all others
      ];
      example = ["DP-1,3440x1440@180,2560x0,1,vrr,0"];
      type = with lib.types; listOf str;
      description = ''
        The monitor configuration for hyprland.
      '';
    };
    workspace = lib.mkOption {
      default = [];
      example = ["2,monitor:DP-1, default:true"];
      type = with lib.types; listOf str;
      description = ''
        The workspace configuration for hyprland.
      '';
    };
    noAtomic = lib.mkOption {
      default = false;
      example = true;
      type = lib.types.bool;
      description = ''
        Use tearing
      '';
    };
    extraAutostart = lib.mkOption {
      default = [];
      example = ["your application"];
      type = lib.types.listOf lib.types.str;
      description = ''
        Extra exec_once.
      '';
    };
    useIronbar = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = ''
        Whether to use ironbar in hyprland.
      '';
    };
    ironbarSingleMonitor = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = ''
        Whether to use ironbar on a single monitor.
      '';
    };
    useDefaultConfig = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = ''
        Use preconfigured Hyprland config.
      '';
    };
    customConfig = lib.mkOption {
      default = {};
      example = {};
      type = with lib.types; attrsOf anything;
      description = ''
        Custom Hyprland configuration.
        Will be merged with default configuration if enabled.
      '';
    };
    plugins = lib.mkOption {
      default = [];
      example = [];
      type = with lib.types; listOf package;
      description = ''
        Plugins to be added to Hyprland.
      '';
    };
    pluginConfig = lib.mkOption {
      default = {};
      example = {};
      type = with lib.types; attrsOf anything;
      description = ''
        Plugin configuration to be added to Hyprland.
      '';
    };
    hyprspaceEnable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      example = true;
      description = ''
        Enables Hyprspace plugin for hyprland.
        Please note, plugins tend to break VERY often.
      '';
    };
    filePickerPortal = lib.mkOption {
      default = "gnome";
      example = "kde";
      type = with lib.types; (enum ["gnome" "kde" "gtk" "disable"]);
      description = ''
        The file picker portal to use with Hyprland.
        Disable removes the config, allowing you to set it yourself.
      '';
    };
  };

  config = lib.mkIf config.mods.hypr.hyprland.enable (
    lib.optionalAttrs (options ? wayland.windowManager.hyprland) {
      # install Hyprland related packages
      home.packages = with pkgs; [
        xorg.xprop
        grim
        slurp
        satty
        xdg-desktop-portal-gtk
        copyq
        wl-clipboard
        hyprcursor
        hyprpicker
        (lib.mkIf (config.mods.hypr.hyprland.filePickerPortal == "kde") xdg-desktop-portal-kde)
        (lib.mkIf (config.mods.hypr.hyprland.filePickerPortal == "gnome") xdg-desktop-portal-gnome)
      ];

      xdg.configFile."xdg-desktop-portal/portals.conf" = lib.mkIf (config.mods.hypr.hyprland.filePickerPortal != "none") {
        text = ''
          [preferred]
          default = hyprland;gtk
          org.freedesktop.impl.portal.FileChooser = ${config.mods.hypr.hyprland.filePickerPortal}
        '';
      };

      wayland.windowManager.hyprland = {
        enable = true;
        package = mkDashDefault pkgs.hyprland;
        plugins =
          [
            (lib.mkIf config.mods.hypr.hyprland.hyprspaceEnable pkgs.hyprlandPlugins.hyprspace)
          ]
          ++ config.mods.hypr.hyprland.plugins;
        settings =
          if config.mods.hypr.hyprland.useDefaultConfig
          then
            lib.mkMerge
            [
              {
                "$mod" = mkDashDefault "SUPER";

                bindm = [
                  "$mod, mouse:272, movewindow"
                  "$mod, mouse:273, resizeactive"
                ];

                bind = [
                  # screenshots
                  ''$mod SUPER,S,exec,grim -g "$(slurp)" - | wl-copy''
                  ''$mod SUPERSHIFT,S,exec,grim -g "$(slurp)" - | satty -f -''

                  # regular programs
                  "$mod SUPER,F,exec,${browserName}"
                  (lib.mkIf (
                    browserName == "firefox" || browserName == "zen"
                  ) "$mod SUPERSHIFT,F,exec,${browserName} -p special")
                  "$mod SUPER,T,exec,kitty -1"
                  "$mod SUPER,E,exec,nautilus -w"
                  "$mod SUPER,N,exec,neovide"
                  (lib.mkIf (config.mods.anyrun.enable) "$mod SUPER,R,exec,anyrun")
                  (lib.mkIf (config.mods.oxi.oxirun.enable) "$mod SUPER,R,exec,oxirun")
                  (lib.mkIf (config.mods.oxi.oxidash.enable) "$mod SUPER,M,exec,oxidash")
                  (lib.mkIf (config.mods.oxi.oxicalc.enable) "$mod SUPER,G,exec,oxicalc")
                  (lib.mkIf (config.mods.oxi.oxishut.enable) "$mod SUPER,D,exec,oxishut")
                  (lib.mkIf (config.mods.oxi.oxipaste.enable) "$mod SUPER,A,exec,oxipaste")
                  (lib.mkIf (config.mods.oxi.hyprdock.enable) "$mod SUPERSHIFT,P,exec,hyprdock --gui")
                  (lib.mkIf (config.mods.hypr.hyprlock.enable) "$mod SUPERSHIFT,L,exec, playerctl -a pause & hyprlock & systemctl suspend")
                  (lib.mkIf (config.mods.hypr.hyprlock.enable) "$mod SUPERSHIFT,K,exec, playerctl -a pause & hyprlock & systemctl hibernate")

                  # media keys
                  (lib.mkIf config.mods.scripts.audioControl ",XF86AudioMute,exec, audioControl mute")
                  (lib.mkIf config.mods.scripts.audioControl ",XF86AudioLowerVolume,exec, audioControl sink -5%")
                  (lib.mkIf config.mods.scripts.audioControl ",XF86AudioRaiseVolume,exec, audioControl sink +5%")
                  ",XF86AudioPlay,exec, playerctl play-pause"
                  ",XF86AudioNext,exec, playerctl next"
                  ",XF86AudioPrev,exec, playerctl previous"
                  (lib.mkIf config.mods.scripts.changeBrightness ",XF86MonBrightnessDown,exec, changeBrightness brightness 10%-")
                  (lib.mkIf config.mods.scripts.changeBrightness ",XF86MonBrightnessUp,exec, changeBrightness brightness +10%")

                  # hyprland keybinds
                  # misc
                  "$mod SUPER,V,togglefloating,"
                  "$mod SUPER,B,fullscreen,"
                  "$mod SUPER,C,togglesplit"
                  "$mod SUPER,Q,killactive,"
                  "$mod SUPERSHIFTALT,M,exit,"
                  "$mod SUPERSHIFT,W,togglespecialworkspace"

                  # move
                  "$mod SUPER,left,movewindow,l"
                  "$mod SUPER,right,movewindow,r"
                  "$mod SUPER,up,movewindow,u"
                  "$mod SUPER,down,movewindow,d"

                  # workspaces
                  "$mod SUPER,1,workspace,1"
                  "$mod SUPER,2,workspace,2"
                  "$mod SUPER,3,workspace,3"
                  "$mod SUPER,4,workspace,4"
                  "$mod SUPER,5,workspace,5"
                  "$mod SUPER,6,workspace,6"
                  "$mod SUPER,7,workspace,7"
                  "$mod SUPER,8,workspace,8"
                  "$mod SUPER,9,workspace,9"
                  "$mod SUPER,0,workspace,10"

                  # move to workspace
                  "$mod SUPERSHIFT,1,movetoworkspace,1"
                  "$mod SUPERSHIFT,2,movetoworkspace,2"
                  "$mod SUPERSHIFT,3,movetoworkspace,3"
                  "$mod SUPERSHIFT,4,movetoworkspace,4"
                  "$mod SUPERSHIFT,5,movetoworkspace,5"
                  "$mod SUPERSHIFT,6,movetoworkspace,6"
                  "$mod SUPERSHIFT,7,movetoworkspace,7"
                  "$mod SUPERSHIFT,8,movetoworkspace,8"
                  "$mod SUPERSHIFT,9,movetoworkspace,9"
                  "$mod SUPERSHIFT,0,movetoworkspace,10"

                  # move to workspace silent
                  "$mod SUPERSHIFTALT,1,movetoworkspacesilent,1"
                  "$mod SUPERSHIFTALT,2,movetoworkspacesilent,2"
                  "$mod SUPERSHIFTALT,3,movetoworkspacesilent,3"
                  "$mod SUPERSHIFTALT,4,movetoworkspacesilent,4"
                  "$mod SUPERSHIFTALT,5,movetoworkspacesilent,5"
                  "$mod SUPERSHIFTALT,6,movetoworkspacesilent,6"
                  "$mod SUPERSHIFTALT,7,movetoworkspacesilent,7"
                  "$mod SUPERSHIFTALT,8,movetoworkspacesilent,8"
                  "$mod SUPERSHIFTALT,9,movetoworkspacesilent,9"
                  "$mod SUPERSHIFTALT,0,movetoworkspacesilent,10"

                  # preselection
                  "$mod SUPERALT,j,layoutmsg,preselect l"
                  "$mod SUPERALT,k,layoutmsg,preselect d"
                  "$mod SUPERALT,l,layoutmsg,preselect u"
                  "$mod SUPERALT,semicolon,layoutmsg,preselect r"
                  "$mod SUPERALT,h,layoutmsg,preselect n"
                ];

                binde = [
                  # hyprland keybinds
                  # focus
                  "$mod SUPER,J,movefocus,l"
                  "$mod SUPER,semicolon,movefocus,r"
                  "$mod SUPER,L,movefocus,u"
                  "$mod SUPER,K,movefocus,d"

                  # resize
                  "$mod SUPER,U,resizeactive,-20 0"
                  "$mod SUPER,P,resizeactive,20 0"
                  "$mod SUPER,O,resizeactive,0 -20"
                  "$mod SUPER,I,resizeactive,0 20"

                  (lib.mkIf config.mods.hypr.hyprland.hyprspaceEnable
                    "SUPER, W, overview:toggle")
                ];

                general = {
                  gaps_out = mkDashDefault "3,5,5,5";
                  border_size = mkDashDefault 3;
                  "col.active_border" = lib.mkOverride 51 "0xFFFF0000 0xFF00FF00 0xFF0000FF 45deg";
                  allow_tearing = lib.mkIf config.mods.hypr.hyprland.noAtomic true;
                };

                decoration = {
                  rounding = mkDashDefault 4;
                };

                render = {
                  direct_scanout = mkDashDefault config.mods.gaming.enable;
                };

                animations = {
                  bezier = mkDashDefault "overshot, 0.05, 0.9, 0.1, 1.2";
                  animation = [
                    "windowsMove,1,4,default"
                    "windows,1,3,overshot,slide bottom"
                    "windowsOut,1,7,default,popin 70%"
                    "border,1,4,default"
                    "fade,1,7,default"
                    "workspaces,1,4,default"
                    "layers,1,2,default,slide"
                  ];
                };

                dwindle = {
                  preserve_split = mkDashDefault true;
                  pseudotile = mkDashDefault 0;
                  permanent_direction_override = mkDashDefault false;
                };

                input = {
                  kb_layout = mkDashDefault "${config.mods.xkb.layout}";
                  kb_variant = mkDashDefault "${config.mods.xkb.variant}";
                  repeat_delay = mkDashDefault 200;
                  force_no_accel = mkDashDefault true;
                  touchpad = {
                    natural_scroll = mkDashDefault true;
                    tap-to-click = mkDashDefault true;
                    tap-and-drag = mkDashDefault true;
                  };
                };

                misc = {
                  animate_manual_resizes = mkDashDefault 1;
                  enable_swallow = mkDashDefault true;
                  disable_splash_rendering = mkDashDefault true;
                  disable_hyprland_logo = mkDashDefault true;
                  swallow_regex = mkDashDefault "^(.*)(kitty)(.*)$";
                  initial_workspace_tracking = mkDashDefault 1;
                  # just doesn't work
                  enable_anr_dialog = false;
                };

                cursor = {
                  enable_hyprcursor = mkDashDefault true;
                  no_hardware_cursors = mkDashDefault (
                    if config.mods.gpu.nvidia.enable
                    then 2
                    else 0
                  );
                  # done with nix, this would break the current setup otherwise
                  sync_gsettings_theme = mkDashDefault false;
                };

                gestures = {
                  workspace_swipe = mkDashDefault true;
                };

                monitor = mkDashDefault config.mods.hypr.hyprland.monitor;
                workspace = mkDashDefault config.mods.hypr.hyprland.workspace;

                env = [
                  "GTK_CSD,0"
                  ''TERM,"kitty /bin/fish"''
                  "XDG_CURRENT_DESKTOP=Hyprland"
                  "XDG_SESSION_TYPE=wayland"
                  "XDG_SESSION_DESKTOP=Hyprland"
                  "HYPRCURSOR_THEME,${config.mods.stylix.cursor.name}"
                  "HYPRCURSOR_SIZE,${toString config.mods.stylix.cursor.size}"
                  "XCURSOR_THEME,${config.mods.stylix.cursor.name}"
                  "XCURSOR_SIZE,${toString config.mods.stylix.cursor.size}"
                  "QT_QPA_PLATFORM,wayland"
                  "QT_QPA_PLATFORMTHEME,qt5ct"
                  "QT_WAYLAND_FORCE_DPI,96"
                  "QT_AUTO_SCREEN_SCALE_FACTOR,0"
                  "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
                  "QT_SCALE_FACTOR,1"
                  ''EDITOR,"neovide --novsync --nofork"''

                  (lib.mkIf config.mods.gpu.nvidia.enable "LIBVA_DRIVER_NAME,nvidia")
                  (lib.mkIf config.mods.gpu.nvidia.enable "XDG_SESSION_TYPE,wayland")
                  (lib.mkIf config.mods.gpu.nvidia.enable "GBM_BACKEND,nvidia-drm")
                  (lib.mkIf config.mods.gpu.nvidia.enable "__GLX_VENDOR_LIBRARY_NAME,nvidia")
                ];

                layerrule = [
                  # layer rules
                  # mainly to disable animations within slurp and grim
                  "noanim, selection"
                ];

                windowrule = [
                  # window rules
                  "float,class:^(.*)(OxiCalc)(.*)$"
                  "float,class:^(.*)(winecfg.exe)(.*)$"
                  "float,class:^(.*)(copyq)(.*)$"
                  "center,class:^(.*)(swappy)(.*)$"
                  "workspace 10 silent,class:^(.*)(steam)(.*)$"

                  # Otherwise neovide will ignore tiling
                  "suppressevent fullscreen maximize,class:^(.*)(neovide)(.*)$"
                ];

                exec-once =
                  [
                    # environment
                    "systemctl --user import-environment"
                    "dbus-update-activation-environment --systemd --all"
                    "hyprctl setcursor ${config.mods.stylix.cursor.name} ${toString config.mods.stylix.cursor.size}"
                    # ensures the systemd service knows what "hyprctl" is :)
                    (lib.mkIf config.mods.gaming.gamemode "systemctl try-restart gamemoded.service --user")

                    # other programs
                    "${browserName}"
                    (lib.mkIf config.mods.oxi.hyprdock.enable "hyprdock --server")
                    (lib.mkIf config.mods.hypr.hyprpaper.enable "hyprpaper")
                    (lib.mkIf config.mods.hypr.hyprland.useIronbar "ironbar")
                    (lib.mkIf config.mods.oxi.oxipaste.enable "oxipaste_daemon")
                    (lib.mkIf config.mods.oxi.oxinoti.enable "oxinoti")
                  ]
                  ++ config.mods.hypr.hyprland.extraAutostart;

                plugin = config.mods.hypr.hyprland.pluginConfig;
              }
              config.mods.hypr.hyprland.customConfig
            ]
          else lib.mkForce config.mods.hypr.hyprland.customConfig;
      };
    }
  );
}
