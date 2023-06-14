{ pkgs, ... }: {
  imports = [
    ../common.nix
    ./brew.nix
    ./preferences.nix
  ];

  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;

  nix.configureBuildUsers = true;

  nix.settings = {
    trusted-substituters = [
      "https://cache.nixos.org"
      "https://anthonyenr1quez.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "anthonyenr1quez.cachix.org-1:Gclb+0ZEVse0quS5IhHiYRsb9QgZ7oSPRfKPNHOl3eI="
    ];
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };
}
