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
