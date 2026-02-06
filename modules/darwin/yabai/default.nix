{ pkgs, lib, ... }:

{
  # Install tools (useful for debugging too)
  environment.systemPackages = with pkgs; [
    yabai
    skhd
  ];

  # Start yabai as a launchd service
  services.yabai = {
    enable = true;

    # Minimal, sane defaults
    config = {
      layout = "bsp";
      auto_balance = "off";
      mouse_follows_focus = "off";
      focus_follows_mouse = "off";
      window_placement = "second_child";

      # “spaces = 4” style behavior is typically handled by scripting,
      # but yabai can label/act on spaces once they exist.
    };

    # Rules are optional; shown as an example
    extraConfig = ''
      # Example: float Settings
      yabai -m rule --add app="System Settings" manage=off
    '';
  };

  # Hotkeys for yabai (skhd)
  services.skhd = {
    enable = true;
    skhdConfig = ''
      # alt - return : open Terminal (example)
      alt - return : open -a Terminal

      # alt - h/j/k/l : focus window
      alt - h : yabai -m window --focus west
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north
      alt - l : yabai -m window --focus east

      # alt - shift - h/j/k/l : move window
      alt + shift - h : yabai -m window --warp west
      alt + shift - j : yabai -m window --warp south
      alt + shift - k : yabai -m window --warp north
      alt + shift - l : yabai -m window --warp east

      # alt - 1..4 : focus space 1..4
      alt - 1 : yabai -m space --focus 1
      alt - 2 : yabai -m space --focus 2
      alt - 3 : yabai -m space --focus 3
      alt - 4 : yabai -m space --focus 4
    '';
  };
}

