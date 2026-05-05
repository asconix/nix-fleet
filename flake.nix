{
  description = "Unified Nix-based provisioning for Linux, macOS, and FreeBSD";

  # All external dependencies of the flake
  inputs = {
    # Nix package repository
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Nix modules for Darwiin
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # Manage Homebrew declaratively using nix-darwin
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };

    # Emacs overlay for Nixpkgs
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
    };

    # Neovim overlay for Nixpkgs
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    # Manage user environment using Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # Secret provisioning using SOPS
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Visual Studio Code extensions
    # https://github.com/nix-community/nix-vscode-extensions
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
  };

  # Build derivations
  outputs = { ... }@inputs:
    with inputs;
    let
      inherit (self) outputs;
      stateVersion = "26.05";
      libx = import ./lib { inherit inputs outputs stateVersion; };
    in {
      darwinConfigurations = {
        # Target systens
        nomnb06 = libx.mkDarwin { hostname = "nomnb06"; };
      };
    };
}
