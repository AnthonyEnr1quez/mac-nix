{ config, pkgs, lib, ... }: {
  hm = {
    firefox-dev = {
      bookmarksToolbar = "never";
      # lol, there has to be an easier way
      extraExtensions = with config.home-manager.users.${config.user.name}.nur.repos.rycee.firefox-addons; [
        facebook-container
        multi-account-containers
        news-feed-eradicator
        reddit-enhancement-suite
      ];
    };

    home.packages = with pkgs; [
      discord
    ];
  };

  homebrew = {
    casks = [
      "balenaetcher"
      "bitwarden"
      "mullvadvpn"
      "signal"
    ];
  };
}
