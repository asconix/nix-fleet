{ pkgs, ... }:

let
  tuna = pkgs.stdenvNoCC.mkDerivation {
    pname = "tuna";
    version = "0.56";
    src = pkgs.fetchurl {
      url = "https://tunaformac.com/download/latest";
      hash = "sha256-bVjPQfQj5yM7Sw3hqbN/t0WQw8n70yvZQRC1oeRTzFg=";
    };
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.unzip ];
    installPhase = ''
      mkdir source
      cd source
      unzip "$src"
      mkdir -p "$out/Applications"
      cp -R "$src" "$out/Applications/Tuna.app"
    '';
  };
in

{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    direnv
    elixir
    fd
    fontconfig
    git
    ripgrep
    tuna
    tmux
  ];
}
