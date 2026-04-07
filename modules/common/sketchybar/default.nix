{ ... }:
{
  home.file = {
    # ".config/sketchybar/sketchybarrc" = {
    ".config/sketchybar/sketchybarrc_tmp" = {
      source = ./sketchybarrc;
      executable = true;
    };

    ".config/sketchybar/colors.sh" = {
      source = ./colors.sh;
    };

    # ".config/sketchybar/plugins/aerospace.sh" = {
    ".config/sketchybar/plugins/aerospace_tmp.sh" = {
      source = ./plugins/aerospace.sh;
      executable = true;
    };

    # ".config/sketchybar/plugins/clock.sh" = {
    ".config/sketchybar/plugins/clock_tmp.sh" = {
      source = ./plugins/clock.sh;
      executable = true;
    };

    # ".config/sketchybar/plugins/icon_map_fn.sh" = {
    ".config/sketchybar/plugins/icon_map_fn_tmp.sh" = {
      source = ./plugins/icon_map_fn.sh;
      executable = true;
    };

    # ".config/sketchybar/items/front_app.sh" = {
    ".config/sketchybar/items/front_app_tmp.sh" = {
      source = ./plugins/icon_map_fn.sh;
    };

    # ".config/sketchybar/items/clock.sh" = {
   ".config/sketchybar/items/clock_tmp.sh" = {
      source = ./plugins/clock.sh;
      executable = true;
    };

    #".config/sketchybar/plugins/volume.sh" = {
    ".config/sketchybar/plugins/volume_tmp.sh" = {
      source = ./plugins/volume.sh;
    };
  };
}