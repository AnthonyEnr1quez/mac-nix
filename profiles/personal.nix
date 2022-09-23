{ config, lib, pkgs, ... }: {
  user.name = "ant";
  hm = { imports = [ ./home-manager/personal.nix ]; };
}
