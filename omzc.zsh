# Opens my Oh My Zsh custom folder, then applies the changes once I'm finished
# editing.
function omzc() {
  code ~/.oh-my-zsh/custom --new-window --wait
  exec zsh
}
