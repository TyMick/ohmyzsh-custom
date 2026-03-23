alias glomr='git pull origin $(git_main_branch) --rebase'
alias glomm='git pull origin $(git_main_branch) --rebase=false'

alias gcaa='git add --all && git commit -v'
alias 'gcaa!'='git add --all && git commit -v --amend'
alias gcaam='git add --all && git commit -m'
alias 'gcaam!'='git add --all && git commit --amend -m'
alias 'gcaan!'='git add --all && git commit -v --no-edit --amend'
alias 'gcaans!'='git add --all && git commit -v -s --no-edit --amend'
alias 'gcmsg!'='git commit --amend -m'
alias gstaa='git stash --all --include-untracked'

# git switch (shorter alternatives to gsw* from the git plugin)
alias gs='git switch'
alias gsd='git switch $(git_develop_branch)'
alias gsm='git switch $(git_main_branch)'
function gsc() {
  local branch="$1"
  if [[ "$PWD" == "$HOME/code/github.com/LogosBible"* ]]; then
    branch="TyMick/$branch"
  fi
  git switch --create "$branch" "${@:2}"
}

alias gsml='git switch $(git_main_branch) && git pull'

# double-stash
alias gdsta='git stash push --keep-index && git stash push && git stash pop 1'
alias gdstaa='git stash --all --include-untracked --keep-index && git stash --all --include-untracked && git stash pop 1'

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
