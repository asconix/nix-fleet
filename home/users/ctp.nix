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

  # Neovim
  #programs.neovim = {
  #  enable = true;
  #  package = pkgs.neovim-nightly;
  #};

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

  xdg.enable = true;

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

  # Visual Studio Code
  programs.vscode = {
    enable = true;

    profiles.default = {
      keybindings = [
        # See https://code.visualstudio.com/docs/getstarted/keybindings#_advanced-customization
        {
            key = "shift+cmd+j";
            command = "workbench.action.focusActiveEditorGroup";
            when = "terminalFocus";
        }
      ];

      userSettings = {
        # This property will be used to prevent generating settings.json:
        # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
        "editor.formatOnSave" = false;
        # Allow VS Code to use the system's trusted SSL certificates
        "http.systemCertificatesNode" = true;
      };

      extensions = 
        (with pkgs.vscode-extensions; [
          aaron-bond.better-comments
          eamodio.gitlens
          esbenp.prettier-vscode
          johnpapa.vscode-peacock
          pkief.material-icon-theme
          ritwickdey.liveserver
        ])
        ++
        (with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
          elixir-lsp.elixir-ls
          jnoortheen.nix-ide
          dracula-theme.theme-dracula
          google.geminicodeassist
          openai.chatgpt
          #Google.gemini-cli-vscode-ide-companion
        ]);
    };
  };

  imports = [
    ../modules/base
    ../modules/emacs
  ];
}
