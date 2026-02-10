{ pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    ripgrep
    fd
  ];
}