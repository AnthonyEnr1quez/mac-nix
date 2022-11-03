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
