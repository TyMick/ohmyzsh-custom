autoload throw

# Open a local repo in VSCodium if it exists on my machine. If it doesn't,
# search for the repo on GitHub, fork it if it isn't mine, clone it onto my
# machine, and then open it in VSCodium.
function dev() {
    setopt EXTENDED_GLOB

    if [[ -d ~/dev/$1 ]]; then
        code ~/dev/$1
    else
        if [[ -n ~/dev/*/$1(#qN) ]]; then
            code ~/dev/*/$1
        else
            if [[ $1 =~ "^([^/]*)/([^/].*)$" ]]; then
                mkdir -p ~/dev/$match[1]
                if [[ $match[1] == "tywmick" ]]; then
                    if gh repo clone $1 -- ~/dev/$1; then
                        code ~/dev/$1
                    else
                        throw
                    fi
                else
                    if gh repo fork $1 --clone=false; then
                        if gh repo clone tywmick/$match[2] -- ~/dev/$1 --depth 1; then
                            code ~/dev/$1
                        else
                            throw
                        fi
                    else
                        throw
                    fi
                fi
            else
                if gh repo clone $1 -- ~/dev/tywmick/$1; then
                    code ~/dev/tywmick/$1
                else
                    throw
                fi
            fi
        fi
    fi

    unsetopt EXTENDED_GLOB
}
