{ config, inputs, pkgs, lib, unstablePkgs, ... }:
{
  home.stateVersion = "24.05";

  # Home Manager option search
  # https://mipmip.github.io/home-manager-option-search

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
