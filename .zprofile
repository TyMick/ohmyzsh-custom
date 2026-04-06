# Symlinked as ~/.zprofile

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Ruby (Homebrew)
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"

# .NET
export PATH="/usr/local/share/dotnet:$PATH"

# fnm (Node version manager)
eval "$(fnm env --use-on-cd --shell zsh)"
