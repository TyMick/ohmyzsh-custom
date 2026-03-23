export PNPM_HOME="/Users/ty.mick/Library/pnpm"

() {
  local paths_to_prepend=(
    "$PNPM_HOME"
  )

  local paths_to_append=(
    "/Users/ty.mick/.dotnet/tools"
  )

  local p
  for p in ${(Oa)paths_to_prepend}; do
    [[ ":$PATH:" != *":$p:"* ]] && export PATH="$p:$PATH"
  done

  for p in $paths_to_append; do
    [[ ":$PATH:" != *":$p:"* ]] && export PATH="$PATH:$p"
  done
}
