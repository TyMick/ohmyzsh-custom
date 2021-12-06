alias aliases='alias-finder -l'

alias disable-shadow='defaults write com.apple.screencapture disable-shadow -bool true && killall SystemUIServer'
alias enable-shadow='defaults write com.apple.screencapture disable-shadow -bool false && killall SystemUIServer'

alias firefox='/Applications/Firefox.app/Contents/MacOS/firefox'

alias gcaa='git add --all && git commit -v'
alias 'gcaa!'='git add --all && git commit -v --amend'
alias gcaam='git add --all && git commit -m'
alias 'gcaam!'='git add --all && git commit --amend -m'
alias 'gcaan!'='git add --all && git commit -v --no-edit --amend'
alias 'gcaans!'='git add --all && git commit -v -s --no-edit --amend'
alias 'gcmsg!'='git commit --amend -m'
alias gstaa='git stash --all --include-untracked'

# double-stash
alias gdsta='git stash push --keep-index && git stash push && git stash pop 1'
alias gdstaa='git stash --all --include-untracked --keep-index && git stash --all --include-untracked && git stash pop 1'

alias mmv='noglob zmv -W'

alias pip='pip3'
alias python='python3'
alias py='python3'

alias update='brew autoremove; brew upgrade; brew autoremove; n lts; yarn --silent global upgrade --latest;'
