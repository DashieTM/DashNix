# Decisions

Log of notable design decisions for LLM continuity. Keep entries concise; do
not duplicate component-specific details that live in module code or docs.

## 2026-10-02: Noctalia suite variant via mods.wm.suite

- `mods.wm.suite` enum `oxi`/`noctalia`/`none` (default `oxi`) selects the shell for both niri and Hyprland; default preserves existing behavior.
- New `modules/programs/noctalia.nix` (`mods.noctalia`) drives upstream `programs.noctalia` (HM scope) plus `recommendedServices` (NixOS scope, per-scope gating via `options ? ...` since nixpkgs ships its own NixOS `programs.noctalia` without settings). Theming intentionally goes through the stylix noctalia target, which derives its palette from the same `stylix.base16Scheme` (accent override respected), avoiding a competing custom palette; user `settings`/`customPalettes` pass through to the upstream module. Dashnix ships noctalia bar defaults (full-width `bar.main` with zero margins/radius, thickness 38, bar font_scale 1.15, clock 1.35 in the `primary` palette role tracking the dashnix accent, workspaces 1.25), all mkDashDefault so user `mods.noctalia.settings` win per key.
- Flake input `noctalia` tracks `github:noctalia-dev/noctalia/cachix` (latest cached commit) with no `nixpkgs.follows`, preserving its binary cache (`noctalia.cachix.org`); wired into `defaultHomeMods` and both cache lists (`base/common_hardware.nix`, root and example `nixConfig`).
- All `mods.oxi.*` configs additionally require `suite == "oxi"`, so switching suites removes oxi packages without touching per-app enables; oxicalc is exempt as compositor-independent (stays enabled with its Mod+G bind and float rule in every suite). Ironbar stays independent. Shared `lib/wm.nix` startup/binds/window-rules are suite-aware (noctalia autostart, float rules, launcher on Mod+Space/Mod+R, control-center on Mod+M, session menu on Mod+D replacing oxishut, clipboard on Mod+A replacing oxipaste, settings on Mod+Shift+D since Mod+Comma is niri's consume-window-into-column; hyprland no-anim layer rule for noctalia namespaces).

## 2026-10-02: Cached Hyprland release and matching graphics stack

- User requested latest release rather than latest master commit. Pin v0.56.2's module input to `efb50993780079460b0cbed1363e2166a2de1d9f`.
- Upstream release-flake compositor had a cache miss. Select official nixpkgs v0.56.2 from `c59305bab2065cfecc4944690d9eedbb56f3a9fa` without overlays. The shared helper asserts the expected version and supplies runtime packages to greetd, Home Manager, GPU configuration, and the ISO.
- `/tmp/hyprgreet.log` identified the startup failure: master compositor's glibc 2.42 could not load host Mesa requiring `GLIBC_2.43`. Match graphics packages to the pinned compositor instead of mixing package sets.
- Enable caches through `nix.settings.substituters`; `trusted-substituters` alone only permits their use. Root flake cache settings are required separately because dependency `nixConfig` is not inherited.
- Consumer `/home/dashie/gits/nixos` uses a local path input so uncommitted framework fixes are included when refreshing its locked source snapshot. Preserve its unrelated dependency revisions. Stale ignored framework lock was moved to `/tmp/opencode/dashnix-flake-lock-before-consumer-sync.json`; dependency lock remains consumer-owned.
- Keep the installer's XWayland build flag enabled to match the official cached compositor; disabling it changes the derivation and requires a source build.
- Verified consumer system/Home Manager compositor derivations match official cached package; compositor, portal, and both Mesa architectures fetched with local builds disabled; generated session and greeter Lua parsed successfully; spaceship system derivation evaluated successfully. Validation executes Lua startup commands, so future checks must stub `hl.exec_cmd`.

## 2026-08-14: OxiBar configurable via mods.oxi.oxibar

`modules/programs/oxi/oxibar.nix` now exposes user-facing options instead of a
hardcoded `plugin_config`.

Options:
- `mods.oxi.oxibar.settings` (`attrsOf anything`) — full OxiBar `plugin_config`
  (plugins list, `[bar]`, per-plugin tables). Default is the previous hardcoded
  config.
- `mods.oxi.oxibar.clock.enable` (default `true`) — removes clock from the
  plugins list, from `bar.center`, and drops the `[clock]` section when unset.
- `mods.oxi.oxibar.battery.enable` (default `false`) — adds `libbattery.so` to
  plugins and `battery` to `bar.end`, and carries `settings.battery` into the
  generated config when set.

Decision: keep the `settings` option type `attrsOf anything` with a
`default`. Setting any sub-path of `settings` *replaces* the whole option value
under the module system (`anything` merge is shallow), so the final
`plugin_config` is computed as `lib.recursiveUpdate defaultSettings
cfg.settings` to regain deep-merge semantics (user keys win, defaults fill the
rest; lists replace wholesale). Enable toggles are applied on top. This mirrors
the ironbar `customConfig` + `useBatteryModule` pattern.

## 2026-08-05: Quiet Hyprland output during Plymouth -> greeter/session handoff

The user wants a seamless Plymouth -> Hyprland transition without compositor
debug output flashing on the TTY. Hyprland's own logging is untouched — it
still writes to `$XDG_RUNTIME_DIR/hypr/<instance>/hyprland.log`; only the
console (stdout/stderr) stream is redirected.

Decisions:

- **Greeter** (`mods.greetd.greeterCommand` default): append
  `> /tmp/hyprgreet.log 2>&1`. greetd runs commands via `sh(1)` with standard
  POSIX shell syntax, so a plain redirect works — no `bash -c` wrapper needed.
- **Session**: the nixpkgs `programs.hyprland` module registers
  `services.displayManager.sessionPackages = [cfg.package]` *in addition to*
  the framework's `mods.greetd.environments` list. To offer only quiet
  sessions, `modules/programs/greetd.nix` now:
  - wraps the Hyprland flake package via `pkgs.symlinkJoin` (`mkQuietSession`,
    name suffix `-quiet-session`): replaces `$out/bin/start-hyprland` with a
    wrapper that does `exec <real>/bin/start-hyprland "$@" >
    /tmp/hyprland-session.log 2>&1`, and patches
    `share/wayland-sessions/hyprland.desktop` `Exec=` to point at the wrapper
    (must `rm` the lndir symlinks before writing replacements — original store
    files are read-only). `passthru.providedSessions` is preserved (required by
    the `sessionPackages` type check).
  - sets `services.displayManager.sessionPackages = lib.mkForce sessionPackages`
    where `sessionPackages` maps the wrapper over `mods.greetd.environments`
    (matching by derivation equality against the flake hyprland package) —
    dropping nixpkgs' unwrapped `[cfg.package]` entry.
  - leaves `programs.hyprland.package` as the real flake package: wrapping it
    would break nixpkgs' `genFinalPackage` (the flake pkg's `.override` is a
    functor; a symlinkJoin result lacks `.override`), and the real package is
    still wanted for `systemPackages`/portal/xwayland handling.
- **Keybind fallback (not implemented)**: to view Hyprland debug on demand,
  bind `Mod+F8` to `spawn-sh` running
  `tail -f $XDG_RUNTIME_DIR/hypr/*/hyprland.log` via the framework's
  `mods.wm.binds` mechanism. The console redirect loses no debug info because
  Hyprland already logs there.

Known caveat: `flake.lock` is gitignored in this repo and was auto-rewritten
("Added input ...") by `nix eval`/`nix build` runs; the resolved nixpkgs input
rev changed from `0954f7ee...` to `e72e4f29...` (stale local lock). The two
revs' relevant module code is identical.
