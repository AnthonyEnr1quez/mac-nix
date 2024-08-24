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
      #      "balenaetcher"
      #      "bitwarden"
      # "blobsaver"
      #      "docker" # TODO, can I replace this w/ podman
      #      "flux"
      #      "geekbench"
      # "impactor"
      # "insomnia"
      # "keepingyouawake"
      #      "linearmouse"
      # "macfuse"
      "mullvadvpn"
      # "obsidian"
      # "raycast"
      # "sensiblesidebuttons"
      #      "signal"
      #      "steam"
      # "unetbootin"
      # "vlc"
    ];
  };
}
