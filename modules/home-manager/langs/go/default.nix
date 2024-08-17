{ pkgs, lib, ... }: {
  programs.go = {
    enable = true;
    package = pkgs.go_1_22.overrideAttrs (_: rec {
      version = "1.22.6";
      src = pkgs.fetchurl {
        url = "https://go.dev/dl/go${version}.src.tar.gz";
        hash = "sha256-nkjZnVGYgleZF9gYnBfpjDc84lq667mHcuKScIiZKlE=";
      };
    });
    goPath = "go";
  };
}