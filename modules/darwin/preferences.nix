{ pkgs, config, ... }: {
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

    # TODO these might not work with latest osx
    loginwindow = {
      autoLoginUser = "${config.user.name}";
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
