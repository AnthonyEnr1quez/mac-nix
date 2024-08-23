{ pkgs, lib, ... }: {

  home.sessionPath = [
    "$GOPATH/bin"
  ];

  programs = {
    go = {
      enable = true;
      package = pkgs.go_1_23.overrideAttrs (_: rec {
        version = "1.23.0";
        src = pkgs.fetchurl {
          url = "https://go.dev/dl/go${version}.src.tar.gz";
          hash = "sha256-Qreo6A2AXaoDAi7T/eQyHUw78smQoUQWXQHu7Nb2mcY=";
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
