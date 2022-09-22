{ config, lib, pkgs, ... }: {
  user.name = "ant";
  hm = 
    # macbook
    if pkgs.stdenvNoCC.isDarwin then
      { imports = [ ./home-manager/personal.nix ]; }
    # wsl
    else
      { imports = [ ./home-manager/personal-copy.nix ]; };
}
