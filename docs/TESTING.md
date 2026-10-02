# Testing

- CI runs Statix, checks Alejandra formatting, and builds documentation through flake outputs.
- Evaluate affected NixOS and Home Manager options before attempting expensive system builds.
- Verify binary-cache compatibility by comparing system and Home Manager package derivation paths with the exact pinned, unoverlaid nixpkgs input.
- Use `nix build --dry-run` with the relevant substituter enabled to distinguish cache downloads from local builds.
- Fetch compositor, portal, and Mesa with `nix build --no-link --max-jobs 0` to prove they require no local source builds.
- Validate generated desktop configuration with the pinned compositor where supported. Hyprland's `--verify-config` executes Lua `hl.exec_cmd` calls; stub that function in an isolated validation config to avoid running startup applications. Runtime login and rendering still need verification after activating a system generation.
