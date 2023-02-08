{
  description = "dotfiles";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://anthonyenr1quez.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "anthonyenr1quez.cachix.org-1:Gclb+0ZEVse0quS5IhHiYRsb9QgZ7oSPRfKPNHOl3eI="
    ];
  };

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.11-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-22.11";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      # inputs.flake-compat.follows = "flake-compat";
      # inputs.flake-utils.follows = "flake-utils";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server = {
      url = "github:msteen/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, darwin, nixos-wsl, vscode-server, ... }:
    let
      isDarwin = system:
        (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);

      # generate a base darwin configuration with the
      # specified hostname, overlays, and any extraModules applied
      mkDarwinConfig =
        { system ? "x86_64-darwin"
        , host
        , nixpkgs ? inputs.nixpkgs
        , stable ? inputs.stable # # TODO is this needed with no overlays?
        , baseModules ? [
            home-manager.darwinModules.home-manager
            ./modules/darwin
            ./hosts
            ./profiles
          ]
        , profile ? "personal"
        , extraModules ? [ ]
        }:
        inputs.darwin.lib.darwinSystem {
          inherit system;
          modules = baseModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs host profile; };
        };

      # generate a base nixos configuration with the
      # specified overlays, hardware modules, and any extraModules applied
      mkNixosConfig =
        { system ? "x86_64-linux"
        , host
        , nixpkgs ? inputs.nixpkgs
        , stable ? inputs.stable
        , baseModules ? [
            home-manager.nixosModules.home-manager
            ./modules/nixos
            ./hosts
            ./profiles
          ]
        , profile ? "personal"
        , extraModules ? [ ]
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = baseModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs host profile; };
        };
    in
    {
      darwinConfigurations = {
        drachenflieger = mkDarwinConfig { host = "drachenflieger"; };
      };

      nixosConfigurations = {
        mothership = mkNixosConfig {
          host = "mothership";
          extraModules = [
            nixos-wsl.nixosModules.wsl
            vscode-server.nixosModule
            ./modules/wsl
          ];
        };
      };

      # TODO make generic with flakeutils
      formatter = {
        x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.nixpkgs-fmt;
        x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      };
    };
}
