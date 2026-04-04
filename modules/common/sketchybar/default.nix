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

    ".config/sketchybar/plugins/icon_map_fn.sh" = {
      source = ./plugins/icon_map_fn.sh;
      executable = true;
    };

    ".config/sketchybar/items/front_app.sh" = {
      source = ./plugins/icon_map_fn.sh;
    };

    ".config/sketchybar/plugins/volume.sh" = {
      source = ./plugins/volume.sh;
    };
  };
}