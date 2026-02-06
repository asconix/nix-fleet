{ pkgs, ... }:

{
  system.activationScripts.wallpaper.text = ''
    WALLPAPER="${./assets/wallpapers/dracula-pro/desktop-2560x1600.png}"

    osascript <<EOF
    tell application "System Events"
      set picture of every desktop to POSIX file "$WALLPAPER"
    end tell
    EOF
  '';
}

