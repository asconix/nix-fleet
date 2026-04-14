{ inputs, outputs, system, ...}:
{
  home.file = {
    "Library/Application Support/Leader Key/config.json" = {
      source = ./config.json;
    };
  };
}
