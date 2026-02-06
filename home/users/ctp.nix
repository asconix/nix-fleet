{ config, inputs, pkgs, lib, unstablePkgs, ... }:
{
  home.stateVersion = "24.05";

  # Home Manager option search
  # https://mipmip.github.io/home-manager-option-search

  # Zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  # Emacs
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };

  # Starship
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  # Dircolors
  programs.dircolors = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    extraConfig = builtins.readFile ./dircolors;  
  };

  # Bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoredups" "ignorespace" ]; # Controlling how commands are saved on the history list2
    historyFileSize = 10000; # Number of history lines to keep on file
    historySize = 10000; # Number of history lines to keep in memory
    shellAliases = {
      c = "clear";
      ls = "ls --color=always";
      l = "ls";
      ll = "ls -Fl";
      la = "ll -a";
      "cd.." = "cd ..";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      grep = "grep --color=auto";
      gs = "git status";
      weather = "curl wttr.in"; # Get current weather forecast for your location
      pubip = "curl icanhazip.com"; # Display external public IP
    };
  };

  # Fish
  programs.fish = {
    enable = true;
    shellAliases = {
      "ll" = "ls -l";
    };
  #  enableCompletion = true;
  #  autosuggestion.enable = true;
    #initExtra = (builtins.readFile ../mac-dot-zshrc);
  };

  # Git
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user = {
        email = "c.pilka@asconix.com";
        name = "Christoph Pilka";
      };
      init = {
        defaultBranch = "main";
      };
      merge = {
        conflictStyle = "diff3";
        tool = "meld";
      };
      pull = {
        rebase = true;
      };
    };
  };
}
