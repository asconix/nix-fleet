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

    ".config/sketchybar/plugins/aerospace.sh" = {
      source = ./plugins/aerospace.sh;
      executable = true;
    };

    ".config/sketchybar/plugins/clock.sh" = {
      source = ./plugins/clock.sh;
      executable = true;
    };
  };
}