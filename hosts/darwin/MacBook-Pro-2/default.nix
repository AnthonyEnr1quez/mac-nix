{ config, pkgs, lib, ... }: {
  hm = {
    imports = [
      ../../../modules/home-manager/firefox
    ];
    
    home = {
      packages = with pkgs; [
        gh
        wget
        terraform
        blackbox
        jetbrains.goland
        jq
        gotools

        (google-cloud-sdk.withExtraComponents
          (with google-cloud-sdk.components; [
            gke-gcloud-auth-plugin
            gcloud-man-pages
          ])
        )
      ];

      sessionPath = [
        "$GOPATH/bin"
      ];

      # direnvs
      # todo get relative path injected somehow
      file = {
        "Projects/moov/mf/.envrc".text = ''
          use flake ~/Projects/nix/dotfiles/hosts/darwin/MacBook-Pro-2/direnvs/mf

          # fix ld linked errors
          # https://stackoverflow.com/questions/71112682/ld-warning-dylib-was-built-for-newer-macos-version-11-3-than-being-linked-1
          # ld: warning: object file (/Users/anthony.enriquez/go/pkg/mod/github.com/confluentinc/confluent-kafka-go/v2@v2.2.0/kafka/librdkafka_vendor/librdkafka_darwin_arm64.a(libcommon-lib-der_ec_key.o)) was built for newer macOS version (12.0) than being linked (11.0)
          # for some reason, cant override this directly in the flake
          export MACOSX_DEPLOYMENT_TARGET=14.0
        '';
      };
    };

    programs = {
      zsh = {
        cdpath = [
          "${config.user.home}/Projects/moov/mf"
        ];
        profileExtra = ''
          eval "$(/opt/homebrew/bin/brew shellenv)"
        '';
        sessionVariables = {
          GOTOOLCHAIN = "local";
          # https://github.com/golang/go/issues/61229#issuecomment-1952798326
          GOFLAGS = "-ldflags=-extldflags=-Wl,-ld_classic";
        };
      };

      go = {
        enable = true;
        package = pkgs.go_1_22.overrideAttrs (_: rec {
          version = "1.22.6";
          src = pkgs.fetchurl {
            url = "https://go.dev/dl/go${version}.src.tar.gz";
            hash = "sha256-nkjZnVGYgleZF9gYnBfpjDc84lq667mHcuKScIiZKlE=";
          };
        });
        goPath = "go";
        goPrivate = [ "github.com/moov-io/*" "github.com/moovfinancial/*" ];
      };
    };
  };

  homebrew = {
    taps = [
      "hashicorp/tap"
    ];
    casks = [
      "docker"
      "google-drive"
      "hashicorp-boundary-desktop"
      "linear-linear"
      "notion"
      "1password"
    ];
  };

  system.defaults.LaunchServices.LSQuarantine = lib.mkForce true;
}
