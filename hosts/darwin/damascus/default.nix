{ config, pkgs, lib, ... }: {
  hm = {
    imports = [
      ../../../modules/home-manager/firefox
    ];

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
