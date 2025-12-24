# Cross-Platform Nix Infrastructure

This repository contains a unified Nix-based configuration for provisioning and managing systems across Linux (NixOS), macOS (`nix-darwin`), and FreeBSD from a single source of truth.

It uses Nix flakes to define reproducible system configurations, shared packages, and user environments while allowing platform-specific customization where required.

## ✨ Key Features

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

## 🎯 Goals

* Provide a consistent developer and user experience across platforms
* Reduce configuration drift between systems
* Make onboarding of new machines fast and predictable
* Serve as a foundation for both personal setups and small fleets

## 🧠 Intended Audience

* Nix users managing multiple operating systems
* Developers who want reproducible environments across laptops and servers
* Anyone experimenting with Nix beyond Linux

## 📁 Repository Structure

This repository is structured to balance code reuse, platform isolation, and long-term maintainability. The core idea is to separate "what is shared" from "what is platform-specific", and separate "system" from "user".

```
.
├── flake.nix
├── flake.lock
├── hosts/
│   ├── linux/
│   │   └── workstation.nix
│   ├── darwin/
│   |   └── server.nix
    └── freebsd/
        └── server.nix
├── modules/
│   ├── common/
│   ├── nixos/
│   ├── darwin/
│   └── freebsd/
├── home/
│   └── user.nix
└── lib/

```

Each directory has a single, clear responsibility, which keeps the flake composable and avoids tightly coupling platforms that behave very differently (NixOS vs macOS vs FreeBSD).

### ❄️  `flake.nix` & `flake.lock`

* `flake.nix` defines:

    * Inputs (`nixpkgs`, `nix-darwin`, `home-manager`, etc.)

    * Outputs for:

        * NixOS systems
        * `nix-darwin` systems
        * FreeBSD configurations
        * Home Manager profiles

* `flake.lock` pins all dependencies to guarantee reproducibility across machines.

Keeping all platforms in a single flake ensures:

    * Shared versions of `nixpkgs`
    * One upgrade path
    * No drift between systems

🖥️ `hosts/` - Machine-Level Configuration

```
hosts/
├── linux/
│   └── workstation.nix
├── darwin/
│   └── macbook.nix
└── freebsd/
    └── server.nix

```

#### Purpose

The `hosts/` directory defines individual machines.

Each file:

* Represents one host
* Wires together:

    * Platform-specific system modules
    * Common modules
    * Hardware- or role-specific settings

#### Why this exists

* Makes it trivial to add a new machine
* Avoids giant, monolithic configs
* Mirrors how NixOS and `nix-darwin` think about systems

#### What belongs here

* Hostnames
* Hardware details
* Filesystem layout
* System services
* Which users exist on that machine

#### What does not belong here

* Reusable logic
* Shared packages
* User dotfiles

