{ profile, config, pkgs, ... }: {
  imports = [ ./${profile} ];
}
