{ inputs, outputs, stateVersion, ...}:
{
  mkDarwin = { hostname, username ? "ctp", system ? "aarch64-darwin",}:
  let
    inherit (inputs.nixpkgs) lib;
    myLibPath = ../lib;
    unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
    customConfPath = ./../hosts/darwin/${hostname};
    customConf = if builtins.pathExists (customConfPath) then (customConfPath + "/default.nix") else ./../hosts/common/darwin-common-dock.nix;
  in
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit system inputs username unstablePkgs myLibPath; };
      #extraSpecialArgs = { inherit inputs; }
      modules = [
        ../hosts/common/common-packages.nix
        ../hosts/common/darwin-common.nix
        ../hosts/common/shell.nix
        ../modules/common/bash/default.nix
        ../modules/common/emacs/default.nix
        customConf
        # ../pkgs/overlays/default.nix
        {
          # nixpkgs.overlays = import ./pkgs/overlays/default.nix { inherit inputs; };
          nixpkgs.overlays = import ../pkgs/overlays { inherit inputs; };
        }
        #{
          #nixpkgs.overlays = [
            # Add nodejs overlay to fix build issues (https://github.com/NixOS/nixpkgs/issues/402079)
            #(final: prev: {
            #  nodejs = prev.nodejs_22;
            #  "nodejs-slim" = prev."nodejs-slim_22";
            #})

            # Add Emacs community overlay
            # inputs.emacs-overlay.overlays.default
            
            # Your repo-local overlay(s) remain separate
            #(final: prev: {
            #  myPkgs = import ./pkgss { pkgs = final; };
            #})
        #    (import (builtins.fetchTarball {
        #      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
        #    }))
         # ];
       # }

        # Home Manager  
        inputs.home-manager.darwinModules.home-manager {
            networking.hostName = hostname;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.extraSpecialArgs = { inherit inputs; };
            #home-manager.sharedModules = [ inputs.nixvim.homeManagerModules.nixvim ];
            home-manager.users.${username} = { imports = [ ./../home/users/${username}.nix ]; };
        }

        # Homebrew
        inputs.nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            autoMigrate = true;
            mutableTaps = true;
            user = "${username}";
            taps = with inputs; {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
              "homebrew/homebrew-bundle" = homebrew-bundle;
            };
          };
        }
      ];
    };
}