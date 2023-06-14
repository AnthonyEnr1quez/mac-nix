{ config, pkgs, lib, ... }: {
  hm = {
    home = {
      packages = with pkgs; [
        gh
        wget
        terraform
        blackbox
        jetbrains.goland
      ];

      sessionPath = [
        "$GOPATH/bin"
      ];
    };

    programs = {
      zsh = {
        profileExtra = ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
      };

      go = {
        enable = true;
        goPath = "go";
        goPrivate = ["github.com/moov-io/*" "github.com/moovfinancial/*"];
      };
    };
  };

  homebrew = {
    casks = [
      "docker"
      "google-drive"
      "linear-linear"
      "notion"
      "postman"
    ];
  };
}
