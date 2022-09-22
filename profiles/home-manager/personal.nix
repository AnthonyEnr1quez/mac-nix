{ config, lib, pkgs, ... }: {
  home.packages = with pkgs; [
    discord
    postman
  ];

  programs.git = {
    userEmail = "32233059+AnthonyEnr1quez@users.noreply.github.com";
    userName = "AnthonyEnr1quez";
  };
}
