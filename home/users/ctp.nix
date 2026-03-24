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

  # AeroSpace
  programs.aerospace = {
    enable = true;

    # Optional: let Home Manager manage startup through launchd
    launchd.enable = true;

    settings = {
      config-version = 2;             # Required version for the config format
      start-at-login = true;          # Launch AeroSpace automatically when macOS starts
      auto-reload-config = true;      # Reload config automatically when the file changes

      # -----------------------------
      # Layout normalization settings
      # -----------------------------

      # Prevents unnecessary nested containers when possible
      enable-normalization-flatten-containers = true;

      # Helps avoid awkward layout orientation when nesting containers
      enable-normalization-opposite-orientation-for-nested-containers = true;

      accordion-padding = 30;
      default-root-container-layout = "tiles";

      gaps = {
        inner.horizontal = 1;
        inner.vertical = 1;
        outer.left = 1;
        outer.bottom = 1;
        outer.top = 1;
        outer.right = 1;
      };

      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # Workspaces
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-tab = "workspace-back-and-forth";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";

        cmd-m = "fullscreen";
      };
    };
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
