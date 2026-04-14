{ inputs, lib, pkgs, ... }:
{
  # Output config file: $HOME/.config/tmux/tmux.conf
  programs.tmux = {
    enable = true;

    # Plugins
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      {
	      plugin = gruvbox;
		    extraConfig = ''
set -g @plugin 'z3z1ma/tmux-gruvbox'
set -g @plugin 'tmux-plugins/tpm'
set -g @gruvbox_flavour 'dark'
set -g @gruvbox_window_left_separator ''
set -g @gruvbox_window_right_separator ' '
set -g @gruvbox_window_middle_separator ' █'
set -g @gruvbox_window_number_position 'right'

set -g @gruvbox_window_default_fill 'number'
set -g @gruvbox_window_default_text '#W'

set -g @gruvbox_window_current_fill 'number' 
set -g @gruvbox_window_current_text "#W"

set -g @gruvbox_status_modules_right "directory user host session"
set -g @gruvbox_status_left_separator  " "
set -g @gruvbox_status_right_separator ""
set -g @gruvbox_status_right_separator_inverse 'no'
set -g @gruvbox_status_fill 'icon'
set -g @gruvbox_status_connect_separator "no"

set -g @gruvbox_directory_text "#{pane_current_path}"
'';
  	  }
    ];

    # Base index for windows and panes
    baseIndex = 1;

    # Use 24 hour clock
    clock24 = false;

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
      set -g renumber-windows off
      # set -g status-right " "
      set -g set-clipboard on
    '';
  };
}
