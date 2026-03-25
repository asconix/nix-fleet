{ pkgs, ... }:

{
  programs.aerospace = {
    enable = true;

    # Optional: let Home Manager manage startup through launchd
    launchd.enable = true;

    settings = {
      config-version = 2;             # Required version for the config format

      # Launch AeroSpace automatically when macOS starts
      start-at-login = true;

      # -------------------------------------------------------------------------------
      # Normalization
      # See https://nikitabobko.github.io/AeroSpace/guide#normalization
      # -------------------------------------------------------------------------------

      # Prevents unnecessary nested containers when possible
      enable-normalization-flatten-containers = true;

      # Helps avoid awkward layout orientation when nesting containers
      enable-normalization-opposite-orientation-for-nested-containers = true;

      # ------
      # Layout
      # ------

      # The 'accordion-padding' specifies the size of accordion padding
      # You can set 0 to disable the padding feature
      # See https://nikitabobko.github.io/AeroSpace/guide#layouts
      accordion-padding = 0;

      # Possible values: tiles|accordion
      default-root-container-layout = "tiles";

      # Possible values: horizontal|vertical|auto
      # 'auto' means: wide monitor (anything wider than high) gets horizontal orientation,
      #               tall monitor (anything higher than wide) gets vertical orientation
      default-root-container-orientation = "auto";

      # ---------
      # Callbacks
      # ---------

      # Mouse follows focus when focused monitor changes
      # Drop it from your config, if you don't like this behavior
      # Fallback value (if you omit the key): on-focused-monitor-changed = []
      # See https://nikitabobko.github.io/AeroSpace/guide#on-focus-changed-callbacks
      # See https://nikitabobko.github.io/AeroSpace/commands#move-mouse
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];

      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.left = 5;
        outer.bottom = 5;
        outer.top = [
          { monitor."built-in" = 10; }
          { monitor."main" = 50; }
          50
        ];
        outer.right = 5;
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

        # Workspaces
        alt-1 = "workspace 1";
        alt-2 = "workspace 2";
        alt-3 = "workspace 3";
        alt-4 = "workspace 4";
        alt-5 = "workspace 5";
        alt-6 = "workspace 6";
        alt-tab = "workspace-back-and-forth";

        alt-shift-1 = "move-node-to-workspace 1";
        alt-shift-2 = "move-node-to-workspace 2";
        alt-shift-3 = "move-node-to-workspace 3";
        alt-shift-4 = "move-node-to-workspace 4";
        alt-shift-5 = "move-node-to-workspace 5";
        alt-shift-6 = "move-node-to-workspace 6";

        cmd-m = "fullscreen";
      };
    };
  };
}
