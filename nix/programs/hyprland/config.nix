{ pkgs
, inputs
, config
, ...
}:
{
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bind = [
      # screenshots
      "$mod SUPER,S,exec,grim -g \"$(slurp)\" - | wl-copy"
      "$mod SUPERSHIFTALT,S,exec, grim -g \"$(slurp)\" $HOME/gits/ost-5semester/Screenshots/$(date +'%Y_%m_%d_%I_%M_%S.png') && (date +'%Y_%m_%d_%I_%M_%S.png') | wl-copy"
      "$mod SUPERSHIFT,S,exec,grim -g \"$(slurp)\" - | satty -f -"
      "$mod SUPERCONTROLSHIFT,S,exec,grim -c -g \"2560,0 3440x1440\" - | wl-copy"

      # regular programs
      "$mod SUPER,F,exec,firefox"
      "$mod SUPER,T,exec,kitty -1"
      "$mod SUPER,E,exec,nautilus -w"
      "$mod SUPER,N,exec,neovide"
      "$mod SUPER,M,exec,oxidash"
      "$mod SUPER,R,exec,anyrun"
      "$mod SUPER,G,exec,oxicalc"
      "$mod SUPER,D,exec,oxishut"
      "$mod SUPER,A,exec,oxipaste"
      "$mod SUPERSHIFT,L,exec, playerctl -a pause & swaylock -c 000000 & systemctl suspend"

      # media keys
      ",XF86AudioMute,exec, $HOME/.config/scripts/audio_control.sh mute"
      ",XF86AudioLowerVolume,exec, $HOME/.config/scripts/audio_control.sh sink -5%"
      ",XF86AudioRaiseVolume,exec, $HOME/.config/scripts/audio_control.sh sink +5%"
      ",XF86AudioPlay,exec, playerctl play-pause"
      ",XF86AudioNext,exec, playerctl next"
      ",XF86AudioPrev,exec, playerctl previous"
      ",XF86MonBrightnessDown,exec, $HOME/.config/scripts/change-brightness brightness 10%-"
      ",XF86MonBrightnessUp,exec, $HOME/.config/scripts/change-brightness brightness +10%"

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
    ];

    general = {
      gaps_out = "3,5,5,5";
      border_size = 3;
      "col.active_border" = "0xFFFF0000 0xFF00FF00 0xFF0000FF 45deg";
      "col.inactive_border" = "0x66333333";
      allow_tearing = true;
    };

    decoration = {
      rounding = 4;
    };

    animations = {
      bezier = "penguin,0.05,0.9,0.1,1.0";
      animation = [
        "windowsMove,1,4,default"
        "windows,1,7,default,popin 70%"
        "windowsOut,1,7,default,popin 70%"
        "border,1,10,default"
        "fade,1,7,default"
        "workspaces,1,6,default"
        "layers,1,3,default,popin"
      ];
    };

    dwindle = {
      preserve_split = true;
      pseudotile = 0;
      permanent_direction_override = false;
    };

    input = {
      kb_layout = "dashie";
      repeat_delay = 200;
      force_no_accel = true;
      touchpad = {
        natural_scroll = true;
        tap-to-click = true;
        tap-and-drag = true;
      };
    };

    misc = {
      vrr = 1;
      animate_manual_resizes = 1;
      enable_swallow = true;
      disable_splash_rendering = true;
      disable_hyprland_logo = true;
      swallow_regex = "^(.*)(kitty)(.*)$";
      # conversion seems to be borked right now, i want a smooth bibata :(
      enable_hyprcursor = false;
    };

    gestures = {
      workspace_swipe = true;
    };

    env = [
      "GTK_CSD,0"
      "TERM,\"kitty /bin/fish\""
      "XDG_CURRENT_DESKTOP=Hyprland"
      "XDG_SESSION_TYPE=wayland"
      "XDG_SESSION_DESKTOP=Hyprland"
      "HYPRCURSOR_THEME,Bibata-Modern-Classic"
      "HYPRCURSOR_SIZE,24"
      "XCURSOR_THEME,Bibata-Modern-Classic"
      "XCURSOR_SIZE,24"
      "QT_QPA_PLATFORM,wayland"
      "QT_QPA_PLATFORMTHEME = \"qt5ct\""
      "QT_WAYLAND_FORCE_DPI,96"
      "QT_AUTO_SCREEN_SCALE_FACTOR,0"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_SCALE_FACTOR,1"
      "EDITOR,\"neovide --novsync --nofork\""
      "WLR_DRM_NO_ATOMIC,1"
      "GTK_USE_PORTAL, 1"
    ];

    layerrule = [
      # layer rules
      # mainly to disable animations within slurp and grim
      "noanim, selection"
    ];

    windowrule = [
      # window rules
      "tile,^(.*)(Spotify)(.*)$"
      "float,^(.*)(OxiCalc)(.*)$"
      "float,^(.*)(winecfg.exe)(.*)$"
      "float,^(.*)(speed.exe)(.*)$"
      "float,^(.*)(copyq)(.*)$"
      "center,^(.*)(swappy)(.*)$"
      "float,title:^(.*)(Spirit)(.*)$"
      "float,title:^(.*)(reset)(.*)$"
      "workspace 10 silent,^(.*)(steam)(.*)$"
      "workspace 9 silent,^(.*)(dota)(.*)$"
      "workspace 9 silent,^(.*)(battlebits)(.*)$"
      "workspace 9 silent,^(.*)(aoe)(.*)$"
      "suppressevent fullscreen maximize,^(.*)(neovide)(.*)$"
    ];

    windowrulev2 = [
      "immediate,class:^(.*)(Pal)$"
      "immediate,class:^(.*)(dota2)$"
      "immediate,class:^(.*)(needforspeedheat.exe)$"
      "forceinput,class:^(.*)(Pal)$"
      "forceinput,class:^(.*)(Battlefield 4)$"
    ];

    exec-once = [
      # environment
      "systemctl --user import-environment"
      "dbus-update-activation-environment --systemd --all"
      "hyprctl setcursor Bibata-Modern-Classic 24"

      # other programs
      "hyprpaper"
      "ironbar"
      "firefox"
      "oxipaste_daemon"
      # TODO: is this necessary?
      #"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
      "nextcloud --background"
      "oxinoti"
    ] ++ config.programs.hyprland.extra_autostart;

    #plugin = {
    #  hyprspace = {
    #    bind = [
    #      "SUPER, W, overview:toggle, toggle"
    #    ];
    #  };
    #};
  };
  #wayland.windowManager.hyprland.plugins = [
  #  inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
  #];
}
