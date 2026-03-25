{ inputs, outputs, stateVersion, ...}:
{
  mkDarwin = { hostname, username ? "ctp", system ? "aarch64-darwin",}:
  let
    inherit (inputs.nixpkgs) lib;
    myLibPath = ../lib;
    unstablePkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
    customConfPath = ./../hosts/darwin/${hostname};
    customConf = if builtins.pathExists (customConfPath) then (customConfPath + "/default.nix") else ./../hosts/common/darwin-common-dock.nix;
    # Dynamically import all modules/common/*/default.nix (all are home-manager modules)
    commonModules = builtins.map
      (name: ../modules/common/${name}/default.nix)
      (builtins.attrNames (builtins.readDir ../modules/common));
  in
    inputs.nix-darwin.lib.darwinSystem {
      specialArgs = { inherit system inputs username unstablePkgs myLibPath; };
      #extraSpecialArgs = { inherit inputs; }
      modules = [
        ../hosts/common/common-packages.nix
        ../hosts/common/darwin-common.nix
        ../hosts/common/shell.nix
        customConf

        {
          nixpkgs.overlays = import ../pkgs/overlays { inherit inputs; };
        }

        # Home Manager  
        inputs.home-manager.darwinModules.home-manager {
          networking.hostName = hostname;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; };
          #home-manager.sharedModules = [ inputs.nixvim.homeManagerModules.nixvim ];
          home-manager.users.${username} = { imports = [ ./../home/users/${username}.nix ] ++ commonModules; };
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
