#========================#
# Oh My Zsh - git plugin #
#========================#
unalias grs
function grs() {
  git reset --soft "HEAD~$1"
}
