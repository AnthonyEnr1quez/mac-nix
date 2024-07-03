{ config, lib, pkgs, ... }: {
  user.name = "ant";

  hm = {
    programs.zsh = {
      sessionVariables = {
        SOPS_AGE_KEY_FILE = "${config.user.home}/.config/sops/age/keys.txt";
      };
    };
  };
}
