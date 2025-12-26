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

    # Manage user environment using Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # Secret provisioning using SOPS
    sops-nix = {
      url = "github:Mic92/sops-nix";
      sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  # Build derivations
  outputs = { ... }@inputs:
    with inputs;
    let
      inherit (self) outputs;

      stateVersion = "25.05";
      libx = import ./lib { inherit inputs outputs stateVersion; };
      
    in {

      darwinConfigurations = {
        # Target systens
        nomnb06 = libx.mkDarwin { hostname = "nomnb06"; };
      };
    };
}
