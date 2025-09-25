function update() {
  nix profile upgrade --all

  brew autoremove
  brew upgrade
  brew autoremove

  mas upgrade

  fnm install 22
  fnm use 22

  gh extension upgrade --all

  exec zsh
}
