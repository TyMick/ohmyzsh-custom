autoload throw

# Picks a lucky teammate for code review.
function crpick() {
  echo "$TEAMMATES[RANDOM % $#TEAMMATES + 1]"
}

# Opens a local repo in VSCodium if it exists on my machine. If it doesn't,
# searches for the repo on GitHub, forks it if it isn't mine, clones it onto my
# machine, and then opens it in VSCodium.
function dev() {
  setopt EXTENDED_GLOB
  local my_username="$GITHUB_USERNAME"

  if [[ $1 =~ "^([^/]*)/([^/]*)$" ]]; then
    if open ~/code/"$1"/.vscode/$match[2].code-workspace; then
    elif [[ -d ~/code/"$1" ]]; then
      # Parse symlinks so VSCodium git integration doesn't get confused
      (readlink ~/code/"$1" || echo ~/code/"$1") | { read dir; code "$dir"; }
    else
      mkdir -p ~/code/$match[1]
      if [[ $match[1] == "$my_username" ]]; then
        if gh repo clone "$1" -- ~/code/"$1"; then
          code ~/code/"$1"
        else
          throw
        fi
      else
        cd ~/code/$match[1]
        if gh repo fork "$1" --clone=true; then
          cd -
          code ~/code/"$1"
        else
          cd -
          throw
        fi
      fi
    fi
  elif [[ $1 =~ "^[^/]*$" ]]; then
    if open ~/code/*/$1/.vscode/$1.code-workspace; then
    elif [[ -d ~/code/*/$1(#qN) ]]; then
      # Parse symlinks so VSCodium git integration doesn't get confused
      (readlink ~/code/*/"$1" || echo ~/code/*/"$1") | { read dir; code "$dir"; }
    else
      if gh repo clone "$my_username/$1" -- ~/code/"$my_username/$1"; then
        code ~/code/"$my_username/$1"
      else
        throw
      fi
    fi
  else
    throw
  fi

  unsetopt EXTENDED_GLOB
}

# Symlinks the current directory into my dev folder hierarchy.
function dev-link() {
  if [[ `git config --local remote.upstream.url` =~ '^https?://(www\.)?github.com/([^/]*)/([^/]*)\.git' ]]; then
    mkdir -p ~/code/$match[2]
    ln -s "$PWD" ~/code/$match[2]/$match[3]
  elif [[ `git config --local remote.upstream.url` =~ '^https?://(www\.)?github.com/([^/]*)/([^/]*)' ]]; then
    mkdir -p ~/code/$match[2]
    ln -s "$PWD" ~/code/$match[2]/$match[3]
  elif [[ `git config --local remote.origin.url` =~ '^https?://(www\.)?github.com/([^/]*)/([^/]*)\.git' ]]; then
    mkdir -p ~/code/$match[2]
    ln -s "$PWD" ~/code/$match[2]/$match[3]
  elif [[ `git config --local remote.origin.url` =~ '^https?://(www\.)?github.com/([^/]*)/([^/]*)' ]]; then
    mkdir -p ~/code/$match[2]
    ln -s "$PWD" ~/code/$match[2]/$match[3]
  else
    throw
  fi
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
