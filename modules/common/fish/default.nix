{ inputs, lib, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      (builtins.readFile ./config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
    ]);

    # inherit (libx) shellAliases;

    plugins = map
      (n: {
        name = n;
        src = inputs.${n};
      }) [
      # "fish-fzf"
      # "fish-foreign-env"
      # "zoxide.fish"
    ];
  };

  programs.starship = {
    enable = true;
    package = pkgs.starship;
    enableTransience = true;
    enableFishIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      container.disabled = true;
      gcloud.disabled = true;
    };
  };
}   