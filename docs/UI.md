# UI

- Desktop behavior and appearance are configured through NixOS and Home Manager modules.
- Shared window-manager options describe monitors, workspaces, keybindings, environment variables, and startup commands.
- Hyprland configuration is generated as Lua; greetd uses a separate Lua compositor configuration.
- Themes are managed through Stylix and the framework's color helpers.
- Preserve host-specific layouts and existing theme conventions when changing shared desktop configuration.
