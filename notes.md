# First steps on Macbook

## In home dir, install nix
`sh <(curl -L https://nixos.org/nix/install)`

## Init nix flake in repo
`nix --experimental-features 'nix-command flakes' flake init`

## Build the darwin config
`nix build .#darwinConfigurations.drachenflieger.system --extra-experimental-features "nix-command flakes"`

## Be able to write stuff to `/`
```sh
printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
```

## Install the darwin config
`./result/sw/bin/darwin-rebuild switch --flake .`

## Restart the shell to get nix changes
`exec zsh`

## After making an additions to the current files (have to commit changes if adding new files)
`darwin-rebuild switch --flake .`

### References
[xyno nix-darwin-introduction](https://xyno.space/post/nix-darwin-introduction)

# Some stuff I've done manually
### TODO Figure out how to automate these
1. Generate SSH key

`ssh-keygen -t ed25519 -C "32233059+AnthonyEnr1quez@users.noreply.github.com"`
  - key name: id_ed25519_github
  - somehow move to xdg dir?
  - Going to add this key to agenix?

2. Add key to ssh agent

`ssh-add ~/.ssh/id_ed25519_github`

3. Install homebrew (this also install command line tools :/)

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
  - have to disable analytics too `brew analytics off`


# TODO
1. Investigate the darwin rebuild command for following error
```
error: not linking environment.etc."nix/nix.conf" because /etc/nix/nix.conf already exists, skipping...
existing file has unknown content ff08c12813680da98c4240328f828647b67a65ba7aa89c022bd8072cba862cf1, move and activate again to apply
```
2. App settings
  - Linear mouse
  - Alt-tab
  - VSCode
  - Firefox

3. Figure out how to just build home manager changes
4. Git Signing Keys
5. kubectl
  - kubeconfig for home cluster in .config folder?
  - kubectl aliases from zshrc
  - kubeps1 prompt
6. Dock config, use dock util?
7. Dir colors, needed anymore when using exa?, config exa?
8. Git config
  - lfs
  - ssh instead of
  - vim as commit editor
9. Go settings (root, path)
10. Jetbrains
  - install
  - keybindings
  - plugins
11. other osx defaults, do I have to open pr to nix darwin?
12. deal with temp dir in playbook repo
13. https://apple.stackexchange.com/questions/199654/how-to-change-system-hide-all-keyboard-shortcut
14. Do I need iterm or kitty, will apple terminal be enough?
15. Check that ssh key is in github with api
