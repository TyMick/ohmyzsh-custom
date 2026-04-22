# Also runs nightly (formulae/gems/etc.) via ~/Library/LaunchAgents/com.tymick.update.plist
# and interactively every Monday morning via ~/Library/LaunchAgents/com.tymick.update-interactive.plist
function update() {
  local my_gems=(xcpretty)
  local ruby_version_before="$(ruby --version)"

  brew upgrade --formula
  brew autoremove
  [[ -t 1 ]] && brew upgrade --cask

  local ruby_version_after="$(ruby --version)"
  if [[ $ruby_version_before != $ruby_version_after ]]; then
    print "Ruby upgraded, restoring gems..."
    gem pristine --all
    gem install "${my_gems[@]}"
  fi

  gem update "${my_gems[@]}"
  gem cleanup "${my_gems[@]}"

  [[ -t 1 ]] && mas upgrade

  fnm install --lts --use

  yarn global upgrade --latest

  gh extension upgrade --all
}
