# { inputs, outputs, user, stateVersion, myLibPath, ... }:
{ pkgs, lib, inputs, outputs, user, stateVersion, myLibPath, ... }:
let
  libx = import myLibPath { inherit inputs outputs user stateVersion; };
in
{
  #programs.bash = {
    #enable = true; # enable Bash completion for all interactive Bash shells
    # historyFileSize = 1024;
    #interactiveShellInit = if builtins.pathExists ./bashrc
    #  then builtins.readFile ./bashrc
    #  else "";
    # interactiveShellInit = builtins.readFile ./bbashrc;

    # inherit (libx) shellAliases;
  #};
}
