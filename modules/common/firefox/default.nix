{ inputs, lib, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default.extensions = [
      {
        id = "uBlock0@raymondhill.net";
        url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
      }
  };
}