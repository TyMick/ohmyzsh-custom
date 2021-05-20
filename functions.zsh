autoload throw

# =================================== dev ==================================== #
# Opens a local repo in VSCodium if it exists on my machine. If it doesn't,
# searches for the repo on GitHub, forks it if it isn't mine, clones it onto my
# machine, and then opens it in VSCodium.
function dev() {
    setopt EXTENDED_GLOB

    if [[ $1 =~ "^([^/]*)/([^/]*)$" ]]; then
        if open ~/code/"$1".code-workspace; then
        elif [[ -d ~/code/"$1" ]]; then
            # Parse symlinks so VSCodium git integration doesn't get confused
            (readlink ~/code/"$1" || echo ~/code/"$1") | { read dir; codium "$dir"; }
        else
            mkdir -p ~/code/$match[1]
            if [[ $match[1] == "tywmick" ]]; then
                if gh repo clone "$1" -- ~/code/"$1"; then
                    codium ~/code/"$1"
                else
                    throw
                fi
            else
                cd ~/code/$match[1]
                if gh repo fork "$1" --clone=true; then
                    cd -
                    codium ~/code/"$1"
                else
                    cd -
                    throw
                fi
            fi
        fi
    elif [[ $1 =~ "^[^/]*$" ]]; then
        if open ~/code/*/"$1".code-workspace; then
        elif [[ -d ~/code/*/$1(#qN) ]]; then
            # Parse symlinks so VSCodium git integration doesn't get confused
            (readlink ~/code/*/"$1" || echo ~/code/*/"$1") | { read dir; codium "$dir"; }
        else
            if gh repo clone tywmick/$1 -- ~/code/tywmick/$1; then
                codium ~/code/tywmick/"$1"
            else
                throw
            fi
        fi
    else
        throw
    fi

    unsetopt EXTENDED_GLOB
}

# ================================= dev-link ================================= #
# Symlinks the current directory into my dev folder hierarchy.
function dev-link() {
    if [[ `git config --local remote.upstream.url` =~ "^https?://(www\.)?github.com/([^/]*)/([^/(\.git)]*)" ]]; then
        mkdir -p ~/code/$match[2]
        ln -s "$PWD" ~/code/$match[2]/$match[3]
    elif [[ `git config --local remote.origin.url` =~ "^https?://(www\.)?github.com/([^/]*)/([^/(\.git)]*)" ]]; then
        mkdir -p ~/code/$match[2]
        ln -s "$PWD" ~/code/$match[2]/$match[3]
    else
        throw
    fi
}

# =================================== omzc =================================== #
# Opens my Oh My Zsh custom folder, then applies the changes once I'm finished
# editing.
function omzc() {
    codium ~/.oh-my-zsh/custom --new-window --wait
    exec zsh
}

# =================================== url ==================================== #
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

# # =================================== web ==================================== #
# # Initiates a web search utilizing DuckDuckGo bangs or opens a URL in the
# # default browser.
# function web() {
#     if [[ "$*" =~ "^https?://" ]]; then
#         open "$*"
#     else
#         web_search duckduckgo "!$*"
#     fi
# }
