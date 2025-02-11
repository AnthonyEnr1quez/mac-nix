{ pkgs, lib, ... }: {

  home.sessionPath = [
    "$GOPATH/bin"
  ];

  home.packages = with pkgs; [
    gotestsum
  ];

  programs = {
    go = {
      enable = true;
      package = pkgs.go_1_24.overrideAttrs (_: rec {
        version = "1.24.0";
        src = pkgs.fetchurl {
          url = "https://go.dev/dl/go${version}.src.tar.gz";
          hash = "sha256-0UEgYUrLKdEryrcr1onyV+tL6eC2+IqPt+Qaxl+FVuU=";
        };
      });
      goPath = "go";
    };

    zsh.sessionVariables = {
      GOTOOLCHAIN = "local";
    };
  };
}
