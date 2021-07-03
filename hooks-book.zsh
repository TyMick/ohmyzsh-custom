function gcbcp() {
  git checkout -b "Checkpoint_$1"
}
function gccp() {
  git checkout "Checkpoint_$1"
}
function grcp() {
  git rebase -i "Checkpoint_$1"
}
