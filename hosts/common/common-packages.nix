{ inputs, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    bitwarden-cli
    # emacs-git
    git-crypt
    git-lfs
    jq
    just
    ripgrep
  ];
}
