{ pkgs, lib, ... }: {

  home.sessionPath = [
    "$GOPATH/bin"
  ];

  programs = {
    go = {
      enable = true;
      package = pkgs.go_1_23.overrideAttrs (_: rec {
        version = "1.23.3";
        src = pkgs.fetchurl {
          url = "https://go.dev/dl/go${version}.src.tar.gz";
          hash = "sha256-jWp3MySHVXxq+iQhExtQ+D20rjxXnDvHLmcO4faWhZk=";
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
