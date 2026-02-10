{ pkgs, lib, config, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
  };

  home.file.".emacs.d/init.el".source = ./init.el;
  home.file.".emacs.d/bootstrap.el".source = ./bootstap.el;
}
