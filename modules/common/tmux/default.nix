{ inputs, lib, pkgs, ... }:
{
  # Output config file: $HOME/.config/tmux/tmux.conf
  programs.tmux = {
    enable = true;

    # Base index for windows and panes
    baseIndex = 1;

    # Use 24 hour clock
    clock24 = true;

    # Disable confirmation prompt before killing a pane or window
    disableConfirmationPrompt = true;

    # Maximum number of lines held in window history
    historyLimit = 10000;

    # Use vi-style copy mode and text motions inside tmux.
    keyMode = "emacs";

    mouse = true;

    # Automatically spawn a session if trying to attach and none are running
    newSession = true;

    # Set the prefix key
    prefix = "C-a";

    # Set the default-shell tmux variable
    shell = "${pkgs.fish}/bin/fish";

    extraConfig = ''
      unbind C-b
      bind C-a send-prefix

      set -g default-terminal "screen-256color"
      set -g escape-time 10

      # Renumber windows (sequential index)
      set -g renumber-windows on

      # 
      set -g set-clipboard on
    '';
  };
}
