{ config, ... }:
{
  system.defaults.dock = {
    persistent-apps = [
      "/Applications/Google Chrome.app"
      "/Applications/Telegram.app"
      "/Applications/Slack.app"
      "/Applications/Visual Studio Code.app"
    ];
  };
}