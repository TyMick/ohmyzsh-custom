#========================#
# Oh My Zsh - git plugin #
#========================#
alias gca='git add --all && git commit -v'
alias 'gca!'='git add --all && git commit -v --amend'
alias gcam='git add --all && git commit -m'
alias 'gcam!'='git add --all && git commit --amend -m' # Addition
alias 'gcan!'='git add --all && git commit -v --no-edit --amend'
alias 'gcans!'='git add --all && git commit -v -s --no-edit --amend'
alias 'gcmsg!'='git commit --amend -m' # Addition

unalias grs
function grs() {
    git reset --soft "HEAD~$1"
}
