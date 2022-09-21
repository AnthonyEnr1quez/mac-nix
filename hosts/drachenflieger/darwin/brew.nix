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

    taps = [
      "homebrew/cask"
      "homebrew/cask-versions"
    ];
    casks = [
      "alt-tab"
      "balenaetcher"
      "bitwarden"
      # "blobsaver"
      # "docker"
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
