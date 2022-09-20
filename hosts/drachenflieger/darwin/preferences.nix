{ pkgs, ... }: {
  system.defaults = {
    dock = {
      autohide = true;
      autohide-delay = 0.0;
      autohide-time-modifier = 1.0;
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXEnableExtensionChangeWarning = false;
    };

    loginwindow = {
      autoLoginUser = "ant";
      GuestEnabled = false;
      SHOWFULLNAME = false;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
    };

    screencapture = {
      disable-shadow = true;
    };
  };
}