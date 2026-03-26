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

      # You can use it to add commands that run after AeroSpace startup.
      # 'after-startup-command' is run after 'after-login-command'
      # Available commands : https://nikitabobko.github.io/AeroSpace/commands

      # JankyBorders https://github.com/FelixKratz/JankyBorders
      after-startup-command = "exec-and-forget borders >/dev/null 2>&1 & disown";
      # after-startup-command = "exec-and-forget borders style=round width=5.0 hidpi=off active_color=0xffe1e3e4 inactive_color=0xff494d64 >/dev/null 2>&1 & disown";


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

      # Gaps between windows (inner-*) and between monitor edges (outer-*).
      # Possible values:
      # - Constant:     gaps.outer.top = 8
      # - Per monitor:  gaps.outer.top = [{ monitor.main = 16 }, { monitfor."some-pattern" = 32 }, 24]
      #                 In this example, 24 is a default value when there is no match.
      #                 Monitor pattern is the same as for 'workspace-to-monitor-force-assignment'.
      #                 See https://nikitabobko.github.io/AeroSpace/guide#assign-workspaces-to-monitors
      gaps = {
        inner.horizontal = 8;
        inner.vertical = 8;
        outer.top = [
          { monitor."built-in" = 10; }    # Matches MacBook screen (with the notch)
          { monitor."main" = 45; }        # Applies to whichever display is currently "main"
          45                              # Fallback default for all others
        ];
        outer.bottom = 5;
        outer.left = 5;
        outer.right = 5;
      };

      # ---------
      # Callbacks
      # ---------

      # Mouse follows focus when focused monitor changes
      # Drop it from your config, if you don't like this behavior
      # Fallback value (if you omit the key): on-focused-monitor-changed = []
      # See https://nikitabobko.github.io/AeroSpace/guide#on-focus-changed-callbacks
      # See https://nikitabobko.github.io/AeroSpace/commands#move-mouse
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];



      # --------
      # Keyboard
      # --------

      # Possible values: (qwerty|dvorak)
      # See https://nikitabobko.github.io/AeroSpace/guide#key-mapping
      key-mapping = {
        preset = "qwerty";
      };

      # 'main' binding mode declaration
      # 'main' binding mode must be always presented
      # See https://nikitabobko.github.io/AeroSpace/guide#binding-modes
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

        alt-f = "fullscreen";

        # Resize
        # See https://nikitabobko.github.io/AeroSpace/commands#resize
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        # App shortcuts
        alt-t = "exec-and-forget open -a /Applications/Ghostty.app";
        alt-shift-r = "exec-and-forget /opt/homebrew/bin/sketchybar --reload";
      };
    };
  };
}
