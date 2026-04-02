{ pkgs, ... }:

{
  programs.aerospace = {
    enable = true;

    # Optional: let Home Manager manage startup through launchd
    launchd.enable = true;

    settings = {
      # Config version for compatibility and deprecations
      config-version = 2;

      # Start AeroSpace at login
      start-at-login = true;

      # You can use it to add commands that run after AeroSpace startup.
      # 'after-startup-command' is run after 'after-login-command'
      # Available commands : https://nikitabobko.github.io/AeroSpace/commands
      # Execution order:
      # 1. JankyBorders https://github.com/FelixKratz/JankyBorders
      after-startup-command = [
        "exec-and-forget borders style=round width=5.0 hidpi=off active_color=0xffe1e3e4 inactive_color=0xff494d64 >/dev/null 2>&1 & disown"
        "exec-and-forget /opt/homebrew/bin/sketchybar --set aerospace_mode label=MAIN"
      ];
      
      # ---------------------------------------------------------------
      # Normalizations
      # See https://nikitabobko.github.io/AeroSpace/guide#normalization
      # ---------------------------------------------------------------

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
      accordion-padding = 100;

      # Possible values: tiles|accordion
      default-root-container-layout = "tiles";

      # Possible values: horizontal|vertical|auto
      # 'auto' means: wide monitor (anything wider than high) gets horizontal orientation,
      #               tall monitor (anything higher than wide) gets vertical orientation
      default-root-container-orientation = "auto";

      # List of workspaces that should stay alive even when they contain no windows,
      # even when they are invisible.
      # This config version is only available since 'config-version = 2'
      # Fallback value (if you omit the key): persistent-workspaces = []
      persistent-workspaces = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B"
                              "C" "D" "E" "F" "G" "I" "M" "N" "O" "P" "Q"
                              "R" "S" "T" "U" "V" "W" "X" "Y" "Z"];

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
        outer.top = 5;
        outer.bottom = [
          { monitor."built-in" = 30; }    # Matches MacBook screen
          { monitor."main" = 45; }        # Applies to whichever display is currently "main"
          45                              # Fallback default for all others
        ];
        outer.left = 5;
        outer.right = 5;
      };

      # ---------
      # Callbacks
      # ---------

      # A callback that runs every time binding mode changes
      # See https://nikitabobko.github.io/AeroSpace/guide#binding-modes
      # See https://nikitabobko.github.io/AeroSpace/commands#mode
      on-mode-changed = [
        "exec-and-forget /bin/sh -c 'mode=$AEROSPACE_MODE; mode=\${mode:-MAIN}; mode=$(printf \"%s\" \"$mode\" | tr \"[:lower:]\" \"[:upper:]\"); /opt/homebrew/bin/sketchybar --set aerospace_mode label=\"$mode\"'"
      ];

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
      # Fallback value (if you omit the key): mode.main.binding = {}
      # See https://nikitabobko.github.io/AeroSpace/guide#binding-modes
      mode.main.binding = {
        
        # All possible keys:
        # - Letters.        a, b, c, ..., z
        # - Numbers.        0, 1, 2, ..., 9
        # - Keypad numbers. keypad0, keypad1, keypad2, ..., keypad9
        # - F-keys.         f1, f2, ..., f20
        # - Special keys.   minus, equal, period, comma, slash, backslash, quote, semicolon,
        #                   backtick, leftSquareBracket, rightSquareBracket, space, enter, esc,
        #                   backspace, tab, pageUp, pageDown, home, end, forwardDelete,
        #                   sectionSign (ISO keyboards only, european keyboards only)
        # - Keypad special. keypadClear, keypadDecimalMark, keypadDivide, keypadEnter, keypadEqual,
        #                   keypadMinus, keypadMultiply, keypadPlus
        # - Arrows.         left, down, up, right

        # All possible modifiers: cmd, alt, ctrl, shift

        # See https://nikitabobko.github.io/AeroSpace/commands#layout
        alt-slash = "layout tiles horizontal vertical";
        alt-comma = "layout accordion horizontal vertical";

        # See https://nikitabobko.github.io/AeroSpace/commands#focus
        alt-h = "focus left";
        alt-j = "focus down";
        alt-k = "focus up";
        alt-l = "focus right";

        # See https://nikitabobko.github.io/AeroSpace/commands#move
        alt-shift-h = "move left";
        alt-shift-j = "move down";
        alt-shift-k = "move up";
        alt-shift-l = "move right";

        # Workspaces
        # See https://nikitabobko.github.io/AeroSpace/commands#workspace
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
        alt-shift-f = "macos-native-fullscreen";

        # Resize
        # See https://nikitabobko.github.io/AeroSpace/commands#resize
        alt-r = "mode resize";
        alt-shift-minus = "resize smart -50";
        alt-shift-equal = "resize smart +50";

        # App shortcuts
        alt-t = "exec-and-forget open -a /Applications/Ghostty.app";
        alt-shift-r = "exec-and-forget /opt/homebrew/bin/sketchybar --reload";
      };

      mode.resize.binding = {
        h = "resize width -50";
        j = "resize height +50";
        k = "resize height -50";
        l = "resize width +50";

        minus = "resize smart -50";
        equal = "resize smart +50";

        enter = "mode main";
        esc = "mode main";
        r = "mode main";
      };

      # You can effectively turn off macOS "Hide application" (cmd-h) feature by toggling this flag
      # Useful if you don't use this macOS feature, but accidentally hit cmd-h or cmd-alt-h key
      # See https://nikitabobko.github.io/AeroSpace/goodies#disable-hide-app
      automatically-unhide-macos-hidden-apps = false;
    };
  };
}
