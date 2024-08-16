{ config, pkgs, ... }:
let
  # todo, tag with renovate
  firefox-csshacks = pkgs.fetchFromGitHub {
    owner = "MrOtherGuy";
    repo = "firefox-csshacks";
    rev = "9d891a3f9e93ea711284e9d5a4c8e8af16a11196";
    sha256 = "sha256-1bNDvkh3znSXN25i1jNDwPcfPaO/JmtN8yf2/ECX3f4=";
  };

  firefoxDir = "Library/Application\ Support/Firefox";
in
{
  # home.file."${firefoxDir}/profiles.ini".text = ''
  #   [General]
  #   StartWithLastProfile=1
  #   Version=2

  #   [Profile0]
  #   Default=1
  #   IsRelative=1
  #   Name=default
  #   Path=Profiles/default
  # '';

  # https://github.com/nix-community/home-manager/issues/3323
  # https://github.com/nix-community/home-manager/issues/5717
  home.file = {
    "${firefoxDir}/profiles.ini".text = ''
      [InstallCE08E05F30B0DD26]
      Default=Profiles/default
      Locked=1
    '';

    # "".text = ''
    # ''
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition-bin; # using brew

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
}
