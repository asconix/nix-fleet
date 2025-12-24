# Cross-Platform Nix Infrastructure

This repository contains a unified Nix-based configuration for provisioning and managing systems across Linux (NixOS), macOS (nix-darwin), and FreeBSD from a single source of truth.

It uses Nix flakes to define reproducible system configurations, shared packages, and user environments while allowing platform-specific customization where required.

## Key Features

* Single flake, multiple platforms

    * NixOS system configurations for Linux machines
    * nix-darwin configurations for macOS hosts
    • FreeBSD system and user provisioning via `nixpkgs` and `home-manager`

* Declarative system management

    * Operating system configuration, services, and packages defined in Nix
    * Fully reproducible builds across machines

* hared modules & code reuse

    * Common modules for:
  
        * Shells, editors, and CLI tools
        * Development environments
        * User accounts and dotfiles

    * Platform-specific overrides where necessary

* Home Manager integration

    * User environments managed declaratively across all platforms
    * Consistent dotfiles and tooling on Linux, macOS, and FreeBSD

* Flake-native workflows

    * `nix develop` for reproducible dev shells
    * `nix build` and `nix run` for tooling
    * Easy pinning and upgrading of dependencies
