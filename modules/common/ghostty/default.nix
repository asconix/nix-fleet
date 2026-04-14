{ ... }:

{
  home.file = {
    ".config/ghostty/config" = {
      text = ''
        theme = "Gruvbox Dark"
        font-family = "JetBrains Mono"
        font-size = 12
        window-padding-x = 8
        window-padding-y = 8
        command = "/etc/profiles/per-user/ctp/bin/fish --login --interactive"
      '';
    };

    ".config/ghostty/themes/One Dark Pro" = {
      source = ./themes/OneDarkPro;
    };
  };
}