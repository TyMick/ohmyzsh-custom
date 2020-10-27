# Creates a .url file in the current directory
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
