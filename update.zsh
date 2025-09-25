function update() {
  nix profile upgrade --all

  brew autoremove
  brew upgrade
  brew autoremove

  mas upgrade

  fnm install 24
  fnm use 24

  gh extension upgrade --all

  exec zsh
}
