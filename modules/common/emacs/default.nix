{ inputs, outputs, user, stateVersion, myLibPath, lib, pkgs, sources, ... }:
let
  libx = import myLibPath { inherit inputs outputs user stateVersion; };
in
{
  #programs.emacs = {
  #  enable = true;
  #  package = pkgs.emacs;
  #  extraConfig = ''
  #    (setq standard-indent 2)
  #  '';
  #};
}
