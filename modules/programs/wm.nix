{lib, ...}: let
  wmOptions = with lib.types; {
    options = {
      name = lib.mkOption {
        default = "DP-1";
        example = "DP-1";
        type = str;
        description = "Name of the monitor";
      };
      resolutionX = lib.mkOption {
        default = 1920;
        example = 2560;
        type = number;
        description = "ResolutionX of the monitor";
      };
      resolutionY = lib.mkOption {
        default = 1080;
        example = 1440;
        type = number;
        description = "ResolutionY of the monitor";
      };
      refreshrate = lib.mkOption {
        default = 60;
        example = 144;
        type = number;
        description = "Refreshrate of the monitor";
      };
      positionX = lib.mkOption {
        default = 0;
        example = 1920;
        type = number;
        description = "PositionX of the monitor";
      };
      positionY = lib.mkOption {
        default = 0;
        example = 1080;
        type = number;
        description = "PositionY of the monitor";
      };
      scale = lib.mkOption {
        default = 1;
        example = 2;
        type = number;
        description = "Scale of the monitor";
      };
      transform = lib.mkOption {
        default = "0";
        example = "90";
        type = enum ["0" "90" "180" "270" "360"];
        description = "Transform of the monitor";
      };
      vrr = lib.mkOption {
        default = false;
        example = true;
        type = bool;
        description = "VRR status of the monitor";
      };
    };
  };

  modKeys = lib.types.enum ["Mod" "Super" "Alt" "Shift" "Ctrl"];

  bindOptions = with lib.types; {
    options = {
      modKeys = lib.mkOption {
        default = [];
        example = ["Mod"];
        type = listOf modKeys;
        description = "List of modifier keys";
      };
      key = lib.mkOption {
        default = "";
        example = "Q";
        type = str;
        description = "Key to bind";
      };
      command = lib.mkOption {
        default = "";
        example = "killActive";
        type = either str (enum [
          "spawn"
          "spawn-sh"
          "quit"
          "killActive"
          "moveFocusUp"
          "moveFocusRight"
          "moveFocusDown"
          "moveFocusLeft"
          "moveWindowUp"
          "moveWindowRight"
          "moveWindowDown"
          "moveWindowLeft"
        ]);
        description = "Command to execute";
      };
      args = lib.mkOption {
        default = [];
        example = [];
        type = listOf str;
        description = "Additional arguments for the command";
      };
      meta = lib.mkOption {
        default = {};
        example = {};
        type = submodule {
          options = {
            niri = lib.mkOption {
              default = {};
              type = submodule {
                options = {
                  desc = lib.mkOption {
                    default = "";
                    type = str;
                    description = "Description for Hotkey overview";
                  };
                  repeat = lib.mkOption {
                    type = bool;
                    default = true;
                    description = "Whether to repeat the keybind on hold";
                  };
                  allowInhibit = lib.mkOption {
                    type = bool;
                    default = true;
                    description = "Whether to allow inhibiting";
                  };
                };
              };
              description = "Niri meta for keybinds";
            };
            hyprland = lib.mkOption {
              type = attrsOf anything;
            };
          };
        };
        description = "Custom metadata per bind. Note, only supported environments are taken into account.";
      };
    };
  };
  mkSimpleBind = modKeys: key: command: args: {
    inherit modKeys key command args;
  };
  mkBindWithDesc = modKeys: key: command: args: desc:
    {
      meta.niri.desc = desc;
    }
    // mkSimpleBind modKeys key command args;
  defaultBinds = [
    {
      modKeys = ["Mod"];
      key = "W";
      command = "toggle-overview";
      meta.niri = {
        desc = "Overview";
        repeat = false;
      };
    }
    {
      modKeys = ["Mod"];
      key = "Escape";
      command = "toggle-keyboard-shortcuts-inhibit";
      meta.niri = {
        allowInhibit = false;
      };
    }
    (mkSimpleBind ["Mod"] "1" "focus-workspace" ["1"])
    (mkSimpleBind ["Mod"] "2" "focus-workspace" ["2"])
    (mkSimpleBind ["Mod"] "3" "focus-workspace" ["3"])
    (mkSimpleBind ["Mod"] "4" "focus-workspace" ["4"])
    (mkSimpleBind ["Mod"] "5" "focus-workspace" ["5"])
    (mkSimpleBind ["Mod"] "6" "focus-workspace" ["6"])
    (mkSimpleBind ["Mod"] "7" "focus-workspace" ["7"])
    (mkSimpleBind ["Mod"] "8" "focus-workspace" ["8"])
    (mkSimpleBind ["Mod"] "9" "focus-workspace" ["9"])
    (mkSimpleBind ["Mod"] "0" "focus-workspace" ["0"])
    (mkSimpleBind ["Mod" "Alt"] "1" "move-window-to-workspace" ["1"])
    (mkSimpleBind ["Mod" "Alt"] "2" "move-window-to-workspace" ["2"])
    (mkSimpleBind ["Mod" "Alt"] "3" "move-window-to-workspace" ["3"])
    (mkSimpleBind ["Mod" "Alt"] "4" "move-window-to-workspace" ["4"])
    (mkSimpleBind ["Mod" "Alt"] "5" "move-window-to-workspace" ["5"])
    (mkSimpleBind ["Mod" "Alt"] "6" "move-window-to-workspace" ["6"])
    (mkSimpleBind ["Mod" "Alt"] "7" "move-window-to-workspace" ["7"])
    (mkSimpleBind ["Mod" "Alt"] "8" "move-window-to-workspace" ["8"])
    (mkSimpleBind ["Mod" "Alt"] "9" "move-window-to-workspace" ["9"])
    (mkSimpleBind ["Mod" "Alt"] "0" "move-window-to-workspace" ["0"])
    (mkSimpleBind ["Mod" "Ctrl"] "1" "move-column-to-workspace" ["1"])
    (mkSimpleBind ["Mod" "Ctrl"] "2" "move-column-to-workspace" ["2"])
    (mkSimpleBind ["Mod" "Ctrl"] "3" "move-column-to-workspace" ["3"])
    (mkSimpleBind ["Mod" "Ctrl"] "4" "move-column-to-workspace" ["4"])
    (mkSimpleBind ["Mod" "Ctrl"] "5" "move-column-to-workspace" ["5"])
    (mkSimpleBind ["Mod" "Ctrl"] "6" "move-column-to-workspace" ["6"])
    (mkSimpleBind ["Mod" "Ctrl"] "7" "move-column-to-workspace" ["7"])
    (mkSimpleBind ["Mod" "Ctrl"] "8" "move-column-to-workspace" ["8"])
    (mkSimpleBind ["Mod" "Ctrl"] "9" "move-column-to-workspace" ["9"])
    (mkSimpleBind ["Mod" "Ctrl"] "0" "move-column-to-workspace" ["0"])
    (mkSimpleBind ["Mod"] "Tab" "focus-workspace-previous" [])
    (mkSimpleBind ["Mod"] "BracketLeft" "consume-or-expel-window-left" [])
    (mkSimpleBind ["Mod"] "BracketRight" "consume-or-expel-window-right" [])
    (mkSimpleBind ["Mod"] "Comma" "consume-window-into-column" [])
    (mkSimpleBind ["Mod"] "Period" "expel-window-from-column" [])
    (mkSimpleBind ["Mod"] "Y" "switch-preset-column-width" [])
    (mkSimpleBind ["Mod"] "B" "fullscreen-window" [])
    (mkSimpleBind ["Mod" "Shift"] "B" "expand-column-to-available-width" [])
    (mkSimpleBind ["Mod"] "U" "set-column-width" ["-10%"])
    (mkSimpleBind ["Mod"] "P" "set-column-width" ["+10%"])
    (mkSimpleBind ["Mod"] "O" "set-column-width" ["50%"])
    (mkSimpleBind ["Mod" "Shift"] "Minus" "set-window-height" ["-10%"])
    (mkSimpleBind ["Mod" "Shift"] "Equal" "set-window-height" ["+10%"])
    (mkSimpleBind ["Mod"] "V" "toggle-window-floating" [])
    (mkSimpleBind ["Mod" "Shift"] "V" "switch-focus-between-floating-and-tiling" [])
    (mkSimpleBind ["Mod" "Shift"] "M" "quit" [])

    (mkSimpleBind ["Mod"] "J" "moveFocusLeft" [])
    (mkSimpleBind ["Mod"] "K" "moveFocusDown" [])
    (mkSimpleBind ["Mod"] "L" "moveFocusUp" [])
    (mkSimpleBind ["Mod"] "semicolon" "moveFocusRight" [])
    (mkSimpleBind ["Mod"] "Left" "moveWindowLeft" [])
    (mkSimpleBind ["Mod"] "Down" "moveWindowDown" [])
    (mkSimpleBind ["Mod"] "Up" "moveWindowUp" [])
    (mkSimpleBind ["Mod"] "Right" "moveWindowRight" [])
    (mkSimpleBind ["Mod" "Shift"] "J" "focus-monitor-left" [])
    (mkSimpleBind ["Mod" "Shift"] "semicolon" "focus-monitor-right" [])
    (mkSimpleBind ["Mod" "Ctrl"] "J" "move-column-to-monitor-left" [])
    (mkSimpleBind ["Mod" "Ctrl"] "semicolon" "move-column-to-monitor-right" [])
    (mkSimpleBind ["Mod" "Shift"] "Slash" "show-hotkey-overlay" [])

    (mkBindWithDesc ["Mod"] "R" "spawn" ["oxirun"] "Open OxiRun")
    (mkBindWithDesc ["Mod"] "T" "spawn" ["kitty"] "Open Kitty")
    (mkBindWithDesc ["Mod" "Shift"] "L" "spawn" ["hyprlock"] "Lock screen")
    (mkBindWithDesc ["Mod"] "F" "spawn" ["zen"] "Open Zen")
    (mkBindWithDesc ["Mod"] "G" "spawn" ["oxicalc"] "Open Oxicalc")
    (mkBindWithDesc ["Mod"] "A" "spawn" ["oxipaste"] "Open Oxipaste")
    (mkBindWithDesc ["Mod"] "D" "spawn" ["oxishut"] "Open OxiShut")
    (mkBindWithDesc ["Mod"] "M" "spawn" ["oxidash"] "Open OxiDash")
    (mkBindWithDesc ["Mod"] "S" "spawn-sh" [''grim -g \"$(slurp)\" - | wl-copy''] "Take Screenshot")
    (mkBindWithDesc ["Mod" "Shift"] "S" "spawn-sh" [''grim -g \"$(slurp)\" - | satty -f -''] "Take Screenshot and edit")
  ];
in {
  options.mods.wm = {
    modKey = lib.mkOption {
      default = "Super";
      example = "Alt";
      type = modKeys;
      description = "Mod key";
    };

    monitors = lib.mkOption {
      default = [];
      example = [
        {
          name = "DP-1";
          resolutionX = 1920;
          resolutionY = 1080;
          refreshrate = 144;
          positionX = 0;
          positionY = 0;
          scale = 1;
          transform = "0";
          vrr = false;
        }
      ];
      type =
        lib.types.listOf (lib.types.submodule wmOptions);
      description = "Monitor configuration";
    };

    useDefaultBinds = lib.mkOption {
      default = true;
      example = false;
      type = lib.types.bool;
      description = "Whether to use default keybinds";
    };

    binds = lib.mkOption {
      # TODO beforepr
      default = defaultBinds;
      example = [
        {
          modKeys = ["Mod"];
          key = "Q";
          command = "killActive";
          args = [];
          meta = {
            niri = {
              desc = "Kill the active window";
              repeat = false;
            };
            hyprland = {};
          };
        }
      ];
      type =
        lib.types.listOf (lib.types.submodule bindOptions);
      description = "Bind configuration";
    };
  };
}
