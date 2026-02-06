{ pkgs, lib, ... }:

{
  # Make Bash available as a login shell
  environment.shells = [ pkgs.bash ];
}
