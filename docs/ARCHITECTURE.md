# Architecture

- DashNix is a Nix flake providing reusable NixOS and Home Manager modules.
- `lib/default.nix` exposes `dashNixLib.buildSystems` and `buildHome`, combining framework inputs with consumer host directories and package bundles.
- Shared system defaults live in `base/`, Home Manager defaults in `home/`, and configurable features in `modules/`.
- `example/` provides a consumer flake; `iso/` provides the installer image.
- Hyprland's module/source input is pinned to a release. Runtime compositor, portal, and graphics packages come from a separate revision-pinned, unoverlaid nixpkgs input via `lib/hyprland-packages.nix`, preserving official binary-cache derivations independently of consumer overlays and updates.
- The greeter, user session, Home Manager, and installer share this package selection. Mesa and userspace graphics drivers must use the compositor's package set because they are loaded into its process and depend on its libc ABI.
- Consumer flakes maintain their own lock graph and must configure build-time caches at the root; dependency `nixConfig` is not inherited.
- `mods.wm.suite` (`oxi`/`noctalia`/`none`, default `oxi`) selects the desktop shell suite for niri and Hyprland. `modules/programs/noctalia.nix` wires the upstream Noctalia home module (tracked via the `noctalia/cachix` flake branch) and the nixpkgs NixOS integration; theming follows the dashnix colorscheme through the stylix noctalia target; all `mods.oxi.*` modules are gated on `suite == "oxi"`.
