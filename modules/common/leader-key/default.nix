{ inputs, outputs, system, ...}:
{
  home.file = {
    "Library/Application Support/Leader Key/config.json" = {
      source = ./config.json;
      # force = true;
    };
  };
  # Plist file is in ~/Library/Preferences/com.brnbw.LeaderKey.plistq
}
