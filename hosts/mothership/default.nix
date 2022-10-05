{ host, config, pkgs, ... }: {
  hm = {
    home = {
      file = { ".vscode-server/server-env-setup".source = ./server-env-setup; };

      packages = with pkgs; [
        htop
        neofetch
        cowsay
      ];
    };
  };
}
