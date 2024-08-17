{ lib, pkgs, config, ... }:
with lib;
let
  name = "firefox-dev";

  hasher = pkgs.buildGoModule rec {
    pname = "hasher";
    version = "0.0.1";
    src = pkgs.fetchFromGitHub rec {
      owner = "AnthonyEnr1quez";
      repo = "mozillainstallhash";
      rev = "nix";
      sha256 = "sha256-7F1KmCJwq0EHfrbHGVV9JSCfhnqJdEGC2zGEHwdQ5E8=";
    };
    doCheck = false;
    vendorHash = "sha256-t98JO8ahPaZWcHDLBs90Aq6jbxuz7YOcKGq4Me5LSiE="; # todo fake
  };
in                    
let
  # todo, tag with renovate
  firefox-csshacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "9d891a3f9e93ea711284e9d5a4c8e8af16a11196";
    sha256 = "sha256-1bNDvkh3znSXN25i1jNDwPcfPaO/JmtN8yf2/ECX3f4=";
  };

  firefoxDir = "Library/Application\ Support/Firefox";
  
  installDirHash = builtins.readFile (pkgs.runCommand "getFFHash" { buildInputs = [ hasher ]; } ''
    mozillainstallhash "${pkgs.firefox-devedition-bin.outPath}/Applications/Firefox Developer Edition.app/Contents/MacOS" > $out
  '');

  cfg = config.${name};
in {
  options.${name} = {
    enable = mkEnableOption "firefox developer edition";
  };

  config = mkIf cfg.enable {

    # https://support.mozilla.org/en-US/kb/understanding-depth-profile-installation#w_new-behaviour
    # https://github.com/nix-community/home-manager/issues/3323
    # https://github.com/nix-community/home-manager/issues/5717
    home.file = {
      "${firefoxDir}/profiles.ini".text = ''
        [Install${installDirHash}]
        Default=Profiles/default
        Locked=1
      '';

      "${firefoxDir}/installs.ini".text = ''
        [${installDirHash}]
        Default=Profiles/default
        Locked=1
      '';
    };

    programs.firefox = {
      enable = true;
      package = pkgs.firefox-devedition-bin;

      profiles.default = {
        isDefault = true;

        extensions = with config.nur.repos.rycee.firefox-addons; [
          bitwarden
          privacy-badger
          refined-github
          sidebery
          ublock-origin
        ];

        settings = {
          # disable auto update
          # "app.update.auto" = false;
          # "app.update.service.enabled" = false;
          # "app.update.download.promptMaxAttempts" = 0;
          # "app.update.elevation.promptMaxAttempts" = 0;

          # always show bookmarks
          "browser.toolbars.bookmarks.showInPrivateBrowsing" = true;
          "browser.toolbars.bookmarks.visibility" = "always";

          "extensions.autoDisableScopes" = 0; # auto-enable extensions
          "extensions.pocket.enabled" = false;

          # privacy
          "privacy.trackingprotection.enabled" = true;
          "privacy.trackingprotection.socialtracking.enabled" = true;
          "privacy.userContext.enabled" = true;

          # disable password manager
          "signon.rememberSignons" = false;
          "signon.autofillForms" = false;

          # enabled userchrome
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };

        userChrome = ''
          @import "${firefox-csshacks}/chrome/hide_tabs_toolbar_osx.css";
          @import "${firefox-csshacks}/window_control_placeholder_support.css;
        '';
      };
    };
  };
}
