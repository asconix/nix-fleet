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
}