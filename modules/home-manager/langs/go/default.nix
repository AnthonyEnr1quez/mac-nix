{ pkgs, lib, ... }: {

  home.sessionPath = [
    "$GOPATH/bin"
  ];

  programs = {
    go = {
      enable = true;
      package = pkgs.go_1_23.overrideAttrs (_: rec {
        version = "1.23.1";
        src = pkgs.fetchurl {
          url = "https://go.dev/dl/go${version}.src.tar.gz";
          hash = "sha256-buROKYN50Ual5aprHFtdX10KM2XqvdcHQebiE0DsOw0=";
        };
      });
      goPath = "go";
    };

    zsh.sessionVariables = {
      GOTOOLCHAIN = "local";
      # https://github.com/golang/go/issues/61229#issuecomment-1952798326
      GOFLAGS = "-ldflags=-extldflags=-Wl,-ld_classic";
    };
  };
}
