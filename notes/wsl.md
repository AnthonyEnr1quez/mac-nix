# wsl testing

# https://xeiaso.net/blog/nix-flakes-4-wsl-2022-05-01
## uninstalling
enter admin powershell prompt

`wsl -l -v`

`wsl --shutdown`

`wsl -l -v`

unregister nix os: `wsl --unregister NixOS`

## installing
import nixos: `wsl --import NixOS .\NixOS\ .\Downloads\nixos-wsl-installer.tar.gz --version 2`

`wsl -d NixOS`: start nix os, it freezes at starting systemd

ctlr-c to quit

shutem down: `wsl --shutdown`

try to have vscode connect to it

## in home dir of nixos user

`nix-shell -p git`

`git clone https://github.com/AnthonyEnr1quez/mac-nix.git`

cd into mac-nix

`sudo nix flake check .` prolly not needed

`sudo nixos-rebuild switch --flake .`
- got error about hostname
- try changing to mothership
- its building on the second try!

after build, open new shell
- looks like pieces are in place

test vscode
- worked on first try!

## lets try shutting it down
`wsl -t NixOS`

run install after and it works with mothership! ??
- it reverted?
