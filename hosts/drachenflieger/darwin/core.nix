{ pkgs, lib, config, ... }: {
  # Make sure the nix daemon always runs
  services.nix-daemon.enable = true;
  
  programs.zsh.enable = true;

  users.users.ant = {
    name = "ant";
    home = "/Users/ant";
  };

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];
  };
}
