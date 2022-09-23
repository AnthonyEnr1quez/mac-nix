{
  description = "My Macbook Config (for now...)";

  inputs = {
      # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
      stable.url = "github:nixos/nixpkgs/nixos-22.05";

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
      #   inputs.flake-compat.follows = "flake-compat";
      #   inputs.flake-utils.follows = "flake-utils";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, darwin, nixos-wsl, ... }: 
    let
      isDarwin = system:
        (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);

      # generate a base darwin configuration with the
      # specified hostname, overlays, and any extraModules applied
      mkDarwinConfig =
        { system ? "x86_64-darwin"
        , nixpkgs ? inputs.nixpkgs
        , stable ? inputs.stable ## TODO is this needed with no overlays?
        , baseModules ? [
            home-manager.darwinModules.home-manager
            ./modules/darwin
          ]
        , extraModules ? [ ]
        }:
        inputs.darwin.lib.darwinSystem {
          inherit system;
          modules = baseModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs; };
        };

      # generate a base nixos configuration with the
      # specified overlays, hardware modules, and any extraModules applied
      mkNixosConfig =
        { system ? "x86_64-linux"
        , nixpkgs ? inputs.nixpkgs
        , stable ? inputs.stable
        , baseModules ? [
            home-manager.nixosModules.home-manager
          ]
        , extraModules ? [ ]
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = baseModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs; };
        };  
  in
  {
    darwinConfigurations = {
      drachenflieger = mkDarwinConfig {
        extraModules = [ ./profiles/personal.nix ];
      };
    };

    nixosConfigurations = {
      nixos = mkNixosConfig {
        extraModules = [ 
          ./modules/nixos
          nixos-wsl.nixosModules.wsl
          {
            wsl = {
              enable = true;
              automountPath = "/mnt";
              defaultUser = "ant";
              startMenuLaunchers = true;
              wslConf.network.hostname = "mothership";
            };
          }
          ./profiles/personal.nix
        ];
      };
    };
  };
}