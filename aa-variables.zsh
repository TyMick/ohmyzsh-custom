# Oh My Zsh executes the scripts in the `custom` folder in alphabetical order,
# so I prepended this file's name with "aa" so I can use these variables in
# subsequent files.

export EDITOR="code --new-window --wait"

export DOTNET_ROOT="/usr/local/opt/dotnet/libexec"

export JAVA_HOME=$(/usr/libexec/java_home -v 17)

export N_PRESERVE_NPM=1

export ZSH_ALIAS_FINDER_AUTOMATIC=true

# disabling telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT=1
export GATSBY_TELEMETRY_DISABLED=1
export HOMEBREW_NO_ANALYTICS=1
export NEXT_TELEMETRY_DISABLED=1
