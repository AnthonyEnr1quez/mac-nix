{ config, lib, pkgs, ... }: {
  user.name = "ant";

  hm = {
    programs.zsh = {
      sessionVariables = {
        KUBECONFIG = "${config.home.homeDirectory}/.config/kube/config";
        SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    };
  };
}
