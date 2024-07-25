{ config, pkgs, ... }: {
  programs.firefox = {
    enable = true;
    package = null; # using brew

    profiles.default = {
      isDefault = true;
      extensions = with config.nur.repos.rycee.firefox-addons; [
        bitwarden
      ];
    };
  };
}
