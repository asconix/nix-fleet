{ inputs, outputs, user, stateVersion, myLibPath, lib, pkgs, sources, ... }:
let
  libx = import myLibPath { inherit inputs outputs user stateVersion; };
in
{
  programs.starship = {
    enable = true;
    package = pkgs.unstable.starship;
    enableTransience = true;
    enableFishIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      container.disabled = true;
      gcloud.disabled = true;
    };
  };
}