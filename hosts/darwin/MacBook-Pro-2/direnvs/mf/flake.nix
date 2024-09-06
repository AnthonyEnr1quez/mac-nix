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
          version = "unstable-2024-08-26";
          src = builtins.fetchGit {
            url = "git@github.com:moovfinancial/bumper.git";
            rev = "f888b5d97029fd8a48e7e685a3c3718a3cc99ba2";
          };
          doCheck = false;
          vendorHash = "sha256-x3SX13FhdWUQpbil1Eoo6IQSRjbEfZKGeNg+819WNCQ=";
        };

        librdkafka = pkgs.rdkafka.overrideAttrs (_: rec {
          version = "unstable-2024-08-30";
          src = pkgs.fetchFromGitHub {
            owner = "confluentinc";
            repo = "librdkafka";
            rev = "9416dd80fb0dba71ff73a8cb4d2b919f54651006"; # tags/v*
            sha256 = "027bdj1qi4iyd7x1w4fp3xkzqrsfpg4i02kysckd50b9z0z121fq";
          };
        });

        # Function to create a basic shell script package
        # https://www.ertt.ca/nix/shell-scripts/#org6f67de6
        # https://github.com/ponkila/HomestakerOS/blob/56523feb33a4e797a1a12e9e11321b6d4b6ce635/flake.nix#L39
        mkScriptPackage = { name, deps }:
          let
            scriptPath = ./scripts + "/${name}.sh";
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
          green-thumb = mkScriptPackage {
            name = "green-thumb";
            deps = [
              pkgs.findutils
              pkgs.gnused
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
