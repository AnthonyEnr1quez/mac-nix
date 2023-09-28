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
          version = "0.3.0";
          src = builtins.fetchGit {
            url = "git@github.com:moovfinancial/bumper.git";
            ref = "v${version}";
            rev = "da5e33b2fd07ba3927004d4106f64d4dce5a2c2a";
          };
          doCheck = false;
          vendorSha256 = "sha256-ix72uivcxw2TzYZnifjbjT0sogdZk5PNEEVpfgitJkY=";
        };

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
          simple-script = mkScriptPackage {
            name = "simple-script";
            deps = [
              pkgs.cowsay
              pkgs.ddate
            ];
          };
        };
        scripts = with builtins; (map (key: getAttr key scriptDefs) (attrNames scriptDefs));

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

            bumper
          ] ++ [
            (writeScriptBin "testing123" ''
              tmp="bob"
              echo hello $tmp!
              which bump
            '')
          ] ++ scripts;

          # env vars
          BUMPER_PD_PATH = "/Users/anthony.enriquez/Projects/moov/mf/platform-dev";
          BUMPER_INFRA_PATH = "/Users/anthony.enriquez/Projects/moov/mf/infra";
        };

        formatter = pkgs.nixpkgs-fmt;
      });
}
