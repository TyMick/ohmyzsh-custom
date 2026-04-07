local my_username="TyMick"
local clone_only_orgs=(github.com/TyMick github.com/LogosBible github.com/LogosBibleLabs)

# Open a local repo in VS Code if it exists on my machine. If it doesn't, search for the repo on GitHub, fork it if it isn't mine, clone it onto my machine, and then open it in VS Code.
dev() {
  local repo_path=(${(s:/:)1})
  local repo=${repo_path[-1]}
  local account=${repo_path[-2]}
  local domain=${repo_path[-3]}

  # Try opening existing VS Code workspace
  setopt local_options null_glob
  local workspace_paths
  if [[ -n "$domain" ]]; then
    workspace_paths=(
      ~/code/$domain/$account/$repo.code-workspace
      ~/code/$domain/$account/$repo/$repo.code-workspace
      ~/code/$domain/$account/$repo/.vscode/$repo.code-workspace
    )
  elif [[ -n "$account" ]]; then
    workspace_paths=(
      ~/code/*/$account/$repo.code-workspace
      ~/code/*/$account/$repo/$repo.code-workspace
      ~/code/*/$account/$repo/.vscode/$repo.code-workspace
    )
  else
    workspace_paths=(
      ~/code/*/*/$repo.code-workspace
      ~/code/*/*/$repo/$repo.code-workspace
      ~/code/*/*/$repo/.vscode/$repo.code-workspace
    )
  fi
  
  local workspace_path
  for workspace_path in ${workspace_paths[@]}; do
    if [[ -e "$workspace_path" ]]; then
      code "$workspace_path"
      return
    fi
  done

  # Try opening existing directory
  local dir_paths
  if [[ -n "$domain" ]]; then
    dir_paths=(~/code/$domain/$account/$repo)
  elif [[ -n "$account" ]]; then
    dir_paths=(~/code/*/$account/$repo)
  else
    dir_paths=(~/code/*/*/$repo)
  fi
  
  local dir_path
  for dir_path in ${dir_paths[@]}; do
    if [[ -e "$dir_path" ]]; then
      # Parse symlinks so VS Code git integration doesn't get confused
      local resolved_path=$(readlink "$dir_path" 2>/dev/null || echo "$dir_path")
      code "$resolved_path"
      return
    fi
  done

  # Try forking and cloning repo (or just cloning if the repo's mine)
  if [[ -z "$domain" ]]; then
    domain='github.com'
  fi
  if [[ -z "$account" ]]; then
    account=$my_username
  fi
  
  mkdir -p ~/code/$domain/$account
  
  local org
  for org in ${clone_only_orgs[@]}; do
    if [[ "$domain/$account" = "$org" ]]; then
      if gh repo clone $domain/$account/$repo -- ~/code/$domain/$account/$repo; then
        code ~/code/$domain/$account/$repo
        return
      fi
    fi
  done
  
  # Automatically decline the clone prompt by piping "n" to the fork command
  if echo "n" | gh repo fork $domain/$account/$repo --default-branch-only; then
    gh repo sync $domain/$my_username/$repo
    gh repo clone $domain/$my_username/$repo ~/code/$domain/$account/$repo
    git -C ~/code/$domain/$account/$repo branch -u upstream/$(git -C ~/code/$domain/$account/$repo symbolic-ref --short HEAD)
    code ~/code/$domain/$account/$repo
    return
  fi

  return 1
}
