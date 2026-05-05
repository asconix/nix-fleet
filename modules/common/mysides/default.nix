{ config, pkgs, lib, ... }:
{
  home.file = {
    # ".config/tuna/config.toml" = {
    "Library/Application\ Support/Tuna/config_tmp.toml" = {
      source = ./config.toml;
    };
  };

  # Plist file is in ~/Library/Preferences/com.brnbw.Tuna.plist
  # defaults read com.brnbw.Tuna.plist
  home.activation.addFavorites = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mysides insert ctp file:///Users/ctp
  '';
}