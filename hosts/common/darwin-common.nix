{ inputs, outputs, config, lib, hostname, system, username, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  users.users.ctp = {
    home = "/Users/ctp";
    shell = pkgs.bash;
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
    channel.enable = false;
  };
  system.stateVersion = 5;

  # Set primary user for system-wide activation
  system.primaryUser = "ctp";

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = lib.mkDefault "${system}";
  };

  environment.systemPackages = with pkgs; [
    # Stable
    pkgs.just
    pkgs.mas 
    pkgs.meld
    pkgs.nix
    pkgs.nodejs
    pkgs.pass
    pkgs.sops
  ];

  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.fira-mono
    pkgs.nerd-fonts.hack
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # Pins to stable as unstable updates very often
  nix.registry = {
    n.to = {
      type = "path";
      path = inputs.nixpkgs;
    };
    u.to = {
      type = "path";
      path = inputs.nixpkgs-unstable;
    };
  };

  programs.nix-index.enable = true;

  programs.fish = {
    enable = true;
  };

  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap"; # Uninstall all formulae not listed in the generated Brewfile
      autoUpdate = true;
      upgrade = true;
    };
    global.autoUpdate = true;

    brews = [
      "sketchybar"
    ];
    taps = [
      "felixkratz/formulae"
    ];
    casks = [
      "claude"
      "chatgpt-atlas"
      "discord"
      "firefox"
      "font-fira-code"
      "font-fira-code-nerd-font"
      "font-fira-mono-for-powerline"
      "font-hack-nerd-font"
      "font-jetbrains-mono-nerd-font"
      "font-meslo-lg-nerd-font"
      "google-chrome"
      "handbrake-app"
      "hammerspoon"
      "istat-menus"
      "iterm2"
      "qbittorrent"
      "signal"
      "slack"
      "spotify"
      "visual-studio-code"
      "vlc"
    ];

    # Mac App Store
    masApps = {
      #"Amazon Prime Video" = 545519333;
      ##"Apple Configurator" = 1037126344;
      #"Authenticator" = 6748213186;
      #"Baby Monitor Bibino: Nanny Cam" = 1514427173;
      #"Bitwarden" = 1352778147;
      #"Blackmagic Disk Speed Test" = 425264550;
      #"Fantastical - Calendar" = 975937182;
      #"Fireplace App" = 413965265;
      #"GarageBand" = 682658836;
      #"HP: Print and Support" = 1474276998; 
      #"HTTPBot: API & HTTP Client" = 1232603544;
      #"iMovie" = 408981434;
      #"Keynote: Design Presentations" = 409183694;
      #"Kindle" = 302584613;
      #"Microsoft Excel" = 462058435;
      #"Microsoft Outlook" = 985367838;
      #"Microsoft PowerPoint" = 462062816;
      #"Microsoft Word" = 462054704;
      #"Night Sky" = 475772902;
      #"Numbers: Make Spreadsheets" = 409203825;
      #"Pages: Create Documents" = 409201541;
      #"reMarkable desktop" = 1276493162;
      #"Slack for Desktop" = 803453959;
      #"Telegram" = 747648890;
      #"WhatsApp Messenger" = 310633997;
      #"Xcode" = 497799835;
      #"Yubico Authenticator" = 1497506650;
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  # macOS system settings
  system.defaults = {
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowScrollBars = "Always";
    NSGlobalDomain.NSUseAnimatedFocusRing = false;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
    NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
    NSGlobalDomain.PMPrintingExpandedStateForPrint2 = true;
    NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    NSGlobalDomain.InitialKeyRepeat = 25;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain.NSWindowShouldDragOnGesture = true;
    NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
    LaunchServices.LSQuarantine = false; # disables "Are you sure?" for new apps
    loginwindow.GuestEnabled = false;
    loginwindow.LoginwindowText = "This device belongs to Christoph Pilka <c.pilka@asconix.com> +47 93961896";
    finder = {
      AppleShowAllFiles = true; # Show hidden files
      AppleShowAllExtensions = true; # Show file extensions
      CreateDesktop = false; # Hide icons on the desktop
      FXPreferredViewStyle = "Nlsv"; # Change the default finder view to list view
      QuitMenuItem = true; # Allow quitting of the Finder
      ShowPathbar = true; # Show path breadcrumbs in finder windows
      ShowStatusBar = true; # Show status bar at bottom of finder windows with item/disk space stats
      _FXShowPosixPathInTitle = true; # Show the full POSIX filepath in the window title
      _FXSortFoldersFirst = true; # Keep folders on top when sorting by name
    };
    menuExtraClock = {
      FlashDateSeparators = true; # Flash the clock indicator on and off each second
      IsAnalog = false; # Show digital clock
      Show24Hour = null; # Show a 24-hour clock, instead of a 12-hour clock
      ShowAMPM = true;
    };
  };

  # WALLPAPER="${../bassets/wallpapers/dracula-pro/desktop-2560x1600.png}"
  system.activationScripts.wallpaper.text = ''
    WALLPAPER="${/tmp/nix-d-nord.jpg}"

    osascript <<EOF
    tell application "System Events"
      set picture of every desktop to POSIX file "$WALLPAPER"
    end tell
    EOF
  '';

  system.defaults.CustomUserPreferences = {
      # Finder
      "com.apple.finder" = {
        ShowExternalHardDrivesOnDesktop = true;
        ShowHardDrivesOnDesktop = false;
        ShowMountedServersOnDesktop = false;
        ShowRemovableMediaOnDesktop = true;
        _FXSortFoldersFirst = true;
        # When performing a search, search the current folder by default
        FXDefaultSearchScope = "SCcf";
        DisableAllAnimations = true;
        NewWindowTarget = "PfDe";
        NewWindowTargetPath = "file://$\{HOME\}/Desktop/";
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        ShowStatusBar = true;
        ShowPathbar = true;
        WarnOnEmptyTrash = false;
      };

      # File and desktop behaviors (network volumes and removable media)
      "com.apple.desktopservices" = {
        # Avoid creating .DS_Store files on network or USB volumes
        DSDontWriteNetworkStores = true;
        DSDontWriteUSBStores = true;
      };

      # Keyboard input, text input methods, and UI event handling
      "com.apple.HIToolbox" = {
        # Completely disable Caps Lock functionality
        AppleFnUsageType = 1; # Enable Fn key functionality
        AppleKeyboardUIMode = 3;
        # Disable Caps Lock toggle entirely
        AppleSymbolicHotKeys = {
          "60" = {
            enabled = false; # Disable Caps Lock toggle hotkey
          };
        };
        # Override modifier key behavior to prevent Caps Lock from functioning
        AppleModifierKeyRemapping = {
          "1452-630-0" = {
            # Map Caps Lock (key code 57/0x39) to nothing (disable it)
            HIDKeyboardModifierMappingSrc = 30064771129; # Caps Lock
            HIDKeyboardModifierMappingDst = 30064771299; # No Action
          };
        };
      };

      # Dock preferences
      "com.apple.dock" = {
        autohide = true; # Automatically hide and show the Dock
        enable-window-tool = true; # Enable Window tool in Mission Control
        launchanim = false; # Animate opening applications
        magnification = false; # Magnification
        mineffect = "scale"; # Minimize effect
        minimize-to-application = true; # Minimize windows into application icon
        orientation = "left"; # Orientation of the Dock
        showhidden = false; # Dim hidden app icons
        show-process-indicators = true; # Show indicators for open applications
        show-recents = false; # Show recent items
        static-only = false;
        tilesize = 36; # Dock icon size
      };

      # Activity Monitor
      "com.apple.ActivityMonitor" = {
        OpenMainWindow = true;
        IconType = 5;
        SortColumn = "CPUUsage";
        SortDirection = 0;
      };

      # Safari
      #"com.apple.Safari" = {
        # Privacy: don’t send search queries to Apple
      #  UniversalSearchEnabled = false;
      #  SuppressSearchSuggestions = true;
      #};

      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
      };

      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        # Check for software updates daily, not just once per week
        ScheduleFrequency = 1;
        # Download newly available updates in background
        AutomaticDownload = 1;
        # Install System data files & security updates
        CriticalUpdateInstall = 1;
      };

      # Time Machine
      "com.apple.TimeMachine" = {
        DoNotOfferNewDisksForBackup = true;
      };

      # Photos
      # Prevent Photos from opening automatically when devices are plugged in
      "com.apple.ImageCapture" = {
        disableHotPlug = true;
      };

      # Turn on app auto-update
      "com.apple.commerce".AutoUpdate = true;
      "com.googlecode.iterm2".PromptOnQuit = false;
      
      # Google Chrome
      "com.google.Chrome" = {
        AppleEnableSwipeNavigateWithScrolls = true;
        DisablePrintPreview = true;
        PMPrintingExpandedStateForPrint2 = true;
      };
  };

}
