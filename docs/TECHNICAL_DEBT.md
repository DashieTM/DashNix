# Technical Debt

- `flake.lock` is ignored by Git in this framework repository; consumer flakes own their tracked dependency locks. Explicit source revision pins are needed for components that must survive broad input updates.
- Full system builds involve many third-party inputs and can fail independently of the desktop compositor.
- Hyprland plugins from a different package set may not match the pinned compositor ABI; plugin compatibility requires separate verification when enabled.
- Binary-cache availability depends on upstream CI publishing the exact derivation, not just matching the source version.
- Upstream Hyprland release v0.56.2's flake compositor was absent from its Cachix cache when checked; the runtime uses the cached official nixpkgs release instead.
- An ignored framework `flake.lock` can override a consumer's nested locks when using a local path input. Keep it absent or deliberately synchronized rather than introducing stale unrelated dependency revisions.
- Sharing pinned graphics drivers prevents compositor libc mismatches but still requires runtime testing of graphics applications when host and pinned package sets differ.
