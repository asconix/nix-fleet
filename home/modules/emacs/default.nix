{ pkgs, lib, config, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-git;
  };

  home.file.".emacs.d/init.el".text = ''
    ;; --- Vanilla init.el managed by Home Manager ---
  '';
}
