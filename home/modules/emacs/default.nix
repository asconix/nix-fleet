{ pkgs, lib, config, ... }:

let
  emacs = pkgs.emacs-git;
  emacsBin = "${emacs}/bin/emacs";
  emacsDir = "${config.home.homeDirectory}/.emacs.d";
in
{
  programs.emacs = {
    enable = true;
    package = emacs;
  };

  # Install the literate config
  home.file.".emacs.d/init.org".source = ./init.org;

  # Bootstrap init.el just loads config.el (no tangling at startup)  
  home.file.".emacs.d/init.el".text = ''
    ;; -*- lexical-binding: t -*-
    (load (expand-file-name "config.el" user-emacs-directory) nil 'nomessage)
  '';

  # Tangle init.org -> config.el during activation
  home.activation.tangleEmacsConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${emacsDir}"
    ${emacsBin} --batch \
      --eval "(require 'org)" \
      --eval "(require 'ob-tangle)" \
      --eval "(org-babel-tangle-file \"${emacsDir}/init.org\" \"${emacsDir}/config.el\" \"emacs-lisp\")"
  '';

  # Start Emacs daemon at login (launchd, user-level)
  launchd.agents.emacs = {
    enable = true;
    config = {
      Label = "org.nix-community.emacs";
      ProgramArguments = [ "${emacs}/bin/emacs" "--fg-daemon" ];
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/tmp/emacs-daemon.out";
      StandardErrorPath = "/tmp/emacs-daemon.err";
    };
  };
}
