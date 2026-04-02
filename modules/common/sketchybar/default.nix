{ ... }:
{
  home.file = {
    ".config/sketchybar/sketchybarrc" = {
      source = ./sketchybarrc;
      executable = true;
    };
    ".config/sketchybar/colors.sh" = {
      source = ./colors.sh;
    };
  };
}