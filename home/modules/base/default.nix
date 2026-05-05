{ pkgs, ... }:

let
  tuna = pkgs.stdenvNoCC.mkDerivation {
    pname = "tuna";
    version = "0.65";
    src = pkgs.fetchurl {
      url = "https://tunaformac.com/download/latest";
      hash = "sha256-7JMq/Qo125GXOvTd4C/zcWarWLruCnvd6X6NXDjxJpo=";
    };
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.unzip ];
    installPhase = ''
      unzip "$src"
      mkdir -p "$out/Applications"
      cp -R Tuna.app "$out/Applications/"
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
    # emacs
    mise-prebuilt
  ];
}
