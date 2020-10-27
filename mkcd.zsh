# Make a new directory than switch to it immediately
function mkcd {
    mkdir -p -- "$1" && cd "$1"
}
