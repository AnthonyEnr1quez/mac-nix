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
    };
  };
}
