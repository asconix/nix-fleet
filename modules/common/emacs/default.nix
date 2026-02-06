{ inputs, outputs, user, stateVersion, myLibPath, lib, pkgs, sources, ... }:
let
  libx = import myLibPath { inherit inputs outputs user stateVersion; };
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };
}
