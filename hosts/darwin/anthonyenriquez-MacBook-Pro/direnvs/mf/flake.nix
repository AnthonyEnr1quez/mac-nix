{
  # todo can I get this in line with my top level flake?
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          # todo this can be removed after updating flake.lock
          # https://search.nixos.org/packages?channel=unstable&show=rdkafka&from=0&size=50&sort=relevance&type=packages&query=rdkafka
          overlays = [
            (final: super: {
              rdkafka = super.rdkafka.overrideAttrs (_: rec {
                version = "v2.2.0";

                src = super.fetchFromGitHub {
                  owner = "confluentinc";
                  repo = "librdkafka";
                  rev = version;
                  hash = "sha256-v/FjnDg22ZNQHmrUsPvjaCs4UQ/RPAxQdg9i8k6ba/4=";
                };
              });
            })
          ];
        };
      in
      {
        devShells.default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            rdkafka
            pkg-config
            libxml2
            google-cloud-sdk

            openssl
            openssl.dev

            cyrus_sasl
            zstd
          ];
        };

        formatter = pkgs.nixpkgs-fmt;
      });
}
