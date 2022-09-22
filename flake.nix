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
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, darwin, ... }: 
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

      # generate a home-manager configuration usable on any unix system
      # with overlays and any extraModules applied
      homePrefix = system: if isDarwin system then "/Users" else "/home";
      mkHomeConfig =
        { username ? "ant"
        , system ? "x86_64-linux"
        , nixpkgs ? inputs.nixpkgs
        , stable ? inputs.stable
        , baseModules ? [
            ./modules/home-manager
            {
              home = {
                inherit username;
                homeDirectory = "${homePrefix system}/${username}";
                # sessionVariables = {
                #   NIX_PATH =
                #     "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
                # };
              };
            }
          ]
        , extraModules ? [ ]
        }:
        inputs.home-manager.lib.homeManagerConfiguration rec {
          pkgs = import nixpkgs {
            inherit system;
          };
          extraSpecialArgs = { inherit self inputs nixpkgs; };
          modules = baseModules ++ extraModules;
        };
  in
  {
    darwinConfigurations = {
      drachenflieger = mkDarwinConfig {
        extraModules = [ ./profiles/personal.nix ];
      };
    };

    homeConfigurations = {
      wsl = mkHomeConfig {
        extraModules = [ ./profiles/home-manager/personal.nix ];
      };
    };
  };
}