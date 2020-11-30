autoload throw


# Opens a local repo in VSCodium if it exists on my machine. If it doesn't,
# searches for the repo on GitHub, forks it if it isn't mine, clones it onto my
# machine, and then opens it in VSCodium.
function dev() {
    setopt EXTENDED_GLOB

    if [[ $1 =~ "^([^/]*)/([^/].*)$" ]]; then
        if [[ -d ~/dev/"$1" ]]; then
            code ~/dev/"$1"
        else
            mkdir -p ~/dev/$match[1]
            if [[ $match[1] == "tywmick" ]]; then
                if gh repo clone "$1" -- ~/dev/"$1"; then
                    code ~/dev/"$1"
                else
                    throw
                fi
            else
                cd ~/dev/$match[1]
                if gh repo fork "$1" --clone=true; then
                    code ~/dev/"$1"
                else
                    cd -
                    throw
                fi
            fi
        fi
    else
        if [[ -d ~/dev/*/$1(#qN) ]]; then
            # Parse symlinks so VSCodium git integration doesn't get confused
            (readlink ~/dev/*/"$1" || echo ~/dev/*/"$1") | { read dir; code "$dir"; }
        else
            if gh repo clone $1 -- ~/dev/tywmick/$1; then
                (readlink ~/dev/tywmick/"$1" || echo ~/dev/tywmick/"$1") | { read dir; code "$dir"; }
            else
                throw
            fi
        fi
    fi

    unsetopt EXTENDED_GLOB
}


# Opens my Oh My Zsh custom folder, then applies the changes once I'm finished
# editing.
function omzc() {
    code ~/.oh-my-zsh/custom --new-window --wait
    exec zsh
}


# Creates a .url file in the current directory.
function url {
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
