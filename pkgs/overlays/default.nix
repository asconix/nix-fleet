{ inputs }:
[
  # External overlays from inputs
  inputs.emacs-overlay.overlays.default
  #inputs.emacs-overlay.overlay
  #inputs.neovim-nightly-overlay.overlay

  # Local overlays
  (import ./nodejs.nix)
  (final: prev: {
    mise-prebuilt = prev.callPackage ../pkgs/mise-prebuilt.nix {};
  })
]
