{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    direnv
    elixir
    fd
    fontconfig
    git
    ripgrep
    tmux
  ];
}
