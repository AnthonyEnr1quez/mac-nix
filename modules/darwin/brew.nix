{ pkgs, ... }: {
  homebrew = {
    enable = true;

    global = {
      autoUpdate = false;
      brewfile = true;
    };
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    brews = [
      # "docker"
      # "ext4fuse" # needed w/ macfuse
    ];

    taps = [
      "homebrew/cask"
      "homebrew/cask-versions"
    ];
    casks = [
      "alt-tab"
      "balenaetcher"
      "bitwarden"
      # "blobsaver"
      "docker" # TODO, can I replace this w/ podman
      "firefox-developer-edition"
      "flux"
      "geekbench"
      # "impactor"
      # "insomnia"
      # "keepingyouawake"
      "linearmouse"
      # "macfuse"
      "mullvadvpn"
      # "obsidian"
      # "raycast"
      # "sensiblesidebuttons"
      "signal"
      "steam"
      # "unetbootin"
      # "vlc"
    ];
  };
}
