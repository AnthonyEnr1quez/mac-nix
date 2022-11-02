{ config, self, ... }: {
  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "${config.user.name}";
    startMenuLaunchers = true;
    wslConf.network.hostname = "${config.host.name}";
    docker-desktop.enable = true;
  };
  services.vscode-server.enable = true;
}
