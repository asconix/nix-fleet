{ pkgs, ... }:

{
  home.packages = with pkgs; [
    direnv
    elixir
    fd
    git
    ripgrep
  ];
}
