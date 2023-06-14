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
      "firefox-developer-edition"
      "logi-options-plus"
    ];
  };
}
