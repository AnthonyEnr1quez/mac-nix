{ config, pkgs, ... }: {
  hm = {
    home.packages = with pkgs; [
      discord
      postman
    ];
  };
}
