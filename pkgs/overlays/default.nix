#{ inputs }:
#[
  # External overlays from inputs
  # inputs.emacs-overlay.overlay
  
  # Local overlay
  # (import ./local.nix)
#]
[
  (final: prev: {
    nodejs = prev.nodejs_22;
    "nodejs-slim" = prev."nodejs-slim_22";
  })
]

