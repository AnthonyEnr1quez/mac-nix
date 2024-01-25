{
  # todo can I get this in line with my top level flake?
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        bumper = pkgs.buildGoModule rec {
          pname = "bumper";
          version = "0.4.3";
          src = builtins.fetchGit {
            url = "git@github.com:moovfinancial/bumper.git";
            ref = "refs/tags/v${version}";
            rev = "9830ac1481e2fee102e151f5d34e49299100fab1";
          };
          doCheck = false;
          vendorHash = "sha256-ix72uivcxw2TzYZnifjbjT0sogdZk5PNEEVpfgitJkY=";
        };

        librdkafka = pkgs.rdkafka.overrideAttrs (_: rec {
          version = "2.3.0";
          src = pkgs.fetchFromGitHub {
            owner = "confluentinc";
            repo = "librdkafka";
            rev = "v${version}";
            sha256 = "sha256-F67aKmyMmqBVG5sF8ZwqemmfvVi/0bDjaiugKKSipuA=";
          };
        });

        # Function to create a basic shell script package
        # https://www.ertt.ca/nix/shell-scripts/#org6f67de6
        # https://github.com/ponkila/HomestakerOS/blob/56523feb33a4e797a1a12e9e11321b6d4b6ce635/flake.nix#L39
        mkScriptPackage = { name, deps }:
          let
            scriptPath = ./scripts/${name}.sh;
            script = (pkgs.writeScriptBin name (builtins.readFile scriptPath)).overrideAttrs (old: {
              buildCommand = "${old.buildCommand}\n patchShebangs $out";
            });
          in
          pkgs.symlinkJoin {
            inherit name;
            paths = [ script ] ++ deps;
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = "wrapProgram $out/bin/${name} --prefix PATH : $out/bin";
          };

        scriptDefs = {
          flip = mkScriptPackage {
            name = "flip";
            deps = [
              pkgs.coreutils
              pkgs.findutils
            ];
          };
          pdev-test = mkScriptPackage {
            name = "pdev-test";
            deps = [
              bumper
              pkgs.coreutils
              pkgs.git
            ];
          };
          pr-comment = mkScriptPackage {
            name = "pr-comment";
            deps = [
              pkgs.jq
              pkgs.gh
            ];
          };
          prep-deploy = mkScriptPackage {
            name = "prep-deploy";
            deps = [
              pkgs.jq
              pkgs.gh
            ];
          };
        };
        scripts = with builtins; (map (key: getAttr key scriptDefs) (attrNames scriptDefs));

      in
      {
        devShells.default = pkgs.mkShellNoCC {
          packages = with pkgs; [
            librdkafka
            pkg-config
            libxml2
            libxml2.dev
            libxslt # TODO unneeded?
            google-cloud-sdk
            jq

            gotools

            openssl
            openssl.dev

            cyrus_sasl
            zstd

            bumper
          ] ++ scripts;

          # env vars
          BUMPER_PD_PATH = "/Users/anthony.enriquez/Projects/moov/mf/platform-dev";
          BUMPER_INFRA_PATH = "/Users/anthony.enriquez/Projects/moov/mf/infra";
        };

        formatter = pkgs.nixpkgs-fmt;
      });
}
