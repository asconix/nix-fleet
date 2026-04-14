{ inputs, pkgs, ... }:

{
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

      # Config file $HOME/Library/Application Support/Code/User/settings.json
      userSettings = {
        # This property will be used to prevent generating settings.json:
        # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
        "editor.formatOnSave" = false;

        "workbench.colorTheme" = "Dracula+";
        
        "files.associations" = {
          "*.nix" = "nix";
        };
        # Allow VS Code to use the system's trusted SSL certificates
        "http.systemCertificatesNode" = true;
        # Font settings for editor
        "editor.fontFamily" = "'Hack Nerd Font', 'FiraCode Nerd Font', monospace";
        "editor.fontLigatures" = true;
        # Font settings for terminal
        "terminal.integrated.fontFamily" = "'Hack Nerd Font Mono', 'FiraCode Nerd Font Mono'";
      };

      extensions = 
        (with pkgs.vscode-extensions; [
          aaron-bond.better-comments
          bbenoist.nix
          eamodio.gitlens
          esbenp.prettier-vscode
          johnpapa.vscode-peacock
          pkief.material-icon-theme
          ritwickdey.liveserver
          jdinhlife.gruvbox
        ])
        ++
        (with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
          elixir-lsp.elixir-ls
          jnoortheen.nix-ide
          google.geminicodeassist
          openai.chatgpt
        ])
        ++ [
          (pkgs.vscode-utils.buildVscodeExtension {
            pname = "dracula-pro";
            version = "2.2.2";
            vscodeExtUniqueId = "dracula.dracula-pro";
            vscodeExtPublisher = "dracula";
            vscodeExtName = "dracula-pro";
            src = ../../../../assets/themes/vscode/dracula-pro.vsix;
          })
        ];
    };
  };
}
