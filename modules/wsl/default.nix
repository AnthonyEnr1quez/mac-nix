{ config, self, lib, pkgs, ... }: {
  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    defaultUser = "${config.user.name}";
    startMenuLaunchers = true;
    wslConf.network.hostname = "${config.host.name}";
    docker-desktop.enable = true;

  # extraBin = [
  #     { src = lib.getExe' pkgs.coreutils "dirname"; }
  #     { src = lib.getExe' pkgs.coreutils "readlink"; }    
  #     { src = lib.getExe' pkgs.coreutils "uname"; }
  #   ];
  };

  services.vscode-server.enable = true;
}
