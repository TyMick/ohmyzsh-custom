# Picks a lucky teammate for code review.
function crpick() {
  echo "$TEAMMATES[RANDOM % $#TEAMMATES + 1]"
}

# Double stash all with message
function gdstaam() {
  git stash --all --include-untracked --keep-index
  git stash --all --include-untracked --message "$1"
  git stash pop 1
}

# Double stash with message
function gdstam() {
  git stash push --keep-index
  git stash push --message "$1"
  git stash pop 1
}

# Opens my Oh My Zsh custom folder, then applies the changes once I'm finished
# editing.
function omzc() {
  code ~/.oh-my-zsh/custom --new-window --wait
  exec zsh
}

# Launch JetBrains Rider
function rider() {
  open -na "Rider.app" --args "$@"
}

# Creates a .url file in the current directory.
function url() {
  if [[ "$2" ]]; then
    url="$2"
    if [[ "$1" == *.url ]]; then
      dest="$1"
    else
      dest="$1.url"
    fi
  else
    url="$1"
    dest="untitled.url"
  fi

  echo "[InternetShortcut]" > "$dest" && echo "URL=$url" >> "$dest"
}
