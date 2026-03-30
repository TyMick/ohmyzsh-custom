# Also runs nightly (formulae/gems/etc.) via ~/Library/LaunchAgents/com.tymick.update.plist
# and interactively every Monday morning via ~/Library/LaunchAgents/com.tymick.update-interactive.plist
function update() {
  local my_gems=(xcpretty)
  local gem_dir_before="$(gem env gemdir)"

  brew upgrade --formula
  brew autoremove
  [[ -t 1 ]] && brew upgrade --cask

  local gem_dir_after="$(gem env gemdir)"
  if [[ $gem_dir_before != $gem_dir_after ]]; then
    print "Ruby upgraded, reinstalling gems in new gem dir..."
    gem install "${my_gems[@]}"
  fi

  gem update "${my_gems[@]}"
  gem cleanup "${my_gems[@]}"

  [[ -t 1 ]] && mas upgrade

  fnm install --lts --use

  yarn global upgrade --latest

  gh extension upgrade --all
}
