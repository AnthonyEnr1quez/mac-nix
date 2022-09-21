{
  description = "My Macbook Config (for now...)";

  inputs = {
      # nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
      nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

      darwin = {
        url = "github:lnl7/nix-darwin";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };
  };
  
  outputs = { self, nixpkgs, home-manager, darwin }: {
    darwinConfigurations.drachenflieger = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./modules/darwin
        home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.ant = import ./modules/home-manager;
          };

          # https://github.com/nix-community/home-manager/issues/2942#issuecomment-1249356730
          nixpkgs.config.allowUnfree = true;
        }
      ];
    };
  };
}