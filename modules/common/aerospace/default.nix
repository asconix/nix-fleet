{ pkgs, ... }:

{
  programs.aerospace = {
    enable = true;

    # Optional: let Home Manager manage startup through launchd
    launchd.enable = true;

    settings = {
      accordion-padding = 30;
      default-root-container-layout = "tiles";

      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        outer.right = 8;
      };

      mode.main.binding = {
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";
      };
    };
  };
}
