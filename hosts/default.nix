{ host, config, pkgs, ... }: {
  host.name = host;

  imports = [ ./${host} ];
}
