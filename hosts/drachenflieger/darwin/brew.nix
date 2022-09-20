{ pkgs, ... }: {
  homebrew = {
    enable = true;
    autoUpdate = false;
    global = {
      brewfile = true;
      # noLock = true;
    };
    onActivation.cleanup = "zap";

    taps = [
      "homebrew/cask"
      "homebrew/cask-versions"
    ];
    casks = [
      "alt-tab"
      "balenaetcher"
      "bitwarden"
      # "docker"
      "firefox-developer-edition"
      "flux"
      "mullvadvpn"
      ### "insomnia"
      ###"keepingyouawake"
      "linearmouse"
      "signal"
      "steam"
      "geekbench"
      "unetbootin"
      ### "macfuse"
      ###"impactor"
      ###"blobsaver"
      # "obsidian"
      # "raycast"
      ####"sensiblesidebuttons"
      ####"the-unarchiver"
      "vlc"
    ];
  };
}