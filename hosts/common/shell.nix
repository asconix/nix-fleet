{ pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
  };

  # Make fish available as a login shell
  environment.shells = [ pkgs.fish ];
}
