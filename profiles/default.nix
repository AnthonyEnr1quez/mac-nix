{ profile, config, pkgs, ... }: {
  imports = [ ./${profile} ];

  hm = {
    programs.git = {
      userEmail = "32233059+AnthonyEnr1quez@users.noreply.github.com";
      userName = "AnthonyEnr1quez";
    };
  };
}
