{ config, ... }:
{
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Firefox.app"
      "/Applications/Telegram.app"
      "/Applications/Signal.app"
      "/Applications/Discord.app"
      "/Applications/Slack.app"
      "/Applications/Spotify.app"
      "/Applications/Visual Studio Code.app"
    ];
  };
}