{ inputs, outputs, config, lib, hostname, system, username, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  users.users.ctp.home = "/Users/ctp";

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
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    global.autoUpdate = true;

    brews = [
      #"bitwarden-cli"
    ];
    taps = [
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
      "signal"
      "slack"
      "spotify"
      "visual-studio-code"
      "vlc"
    ];

    # Mac App Store
    masApps = {
      "Bitwarden" = 1352778147;
      "Disk Speed Test" = 425264550;
      "Fantastical" = 975937182;
      "Telegram" = 747648890;
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
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
    finder.FXPreferredViewStyle = "Nlsv";
  };

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
