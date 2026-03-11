# Oh My Zsh Custom Config — Agent Guide

This is Ty Mick's `~/.oh-my-zsh/custom/` directory. It extends oh-my-zsh with
personal aliases, functions, environment variables, and PATH entries on macOS.

## File loading order

Oh My Zsh loads files in this directory **alphabetically**, so:

- `aa-variables.zsh` loads first — env vars that later files may depend on
- `zz-last.zsh` loads last — Commands that need to be executed at the end of .zshrc

## What each file does

| File | Purpose |
|---|---|
| `aa-variables.zsh` | `export` statements: EDITOR, DOTNET_ROOT, N_PRESERVE_NPM, telemetry opt-outs, zsh plugin config |
| `aliases.zsh` | Simple `alias` one-liners (git shortcuts, app launchers, pip/python remaps) |
| `autoload.zsh` | `autoload` calls (currently just `zmv`) |
| `dev.zsh` | `dev` function — opens a repo in VS Code, forking/cloning from GitHub if needed |
| `git.zsh` | Git-related shell functions (complex operations not suited for aliases) |
| `hooks-book.zsh` | Shortcuts specific to the "hooks book" project (`gcamcp`, `gcbcp`, `gccp`, `grcp`, `rbub`) |
| `omzc.zsh` | `omzc` function — opens this custom folder in VS Code, then reloads zsh when done |
| `overrides.zsh` | Replaces or unsets oh-my-zsh built-in aliases/functions (e.g. `grs`) |
| `path.zsh` | `PATH` additions and tool-root exports (e.g. DOTNET_ROOT) |
| `rider.zsh` | `rider` function — launches JetBrains Rider |
| `update.zsh` | `update` function — upgrades everything (nix, brew, mas, fnm, yarn globals, gh extensions) |
| `url.zsh` | `url` function — creates a Windows-style `.url` shortcut file |

## Where to add new things

- **New alias** → `aliases.zsh` (or `overrides.zsh` if it replaces an oh-my-zsh built-in or plugin)
- **New env var or PATH entry** → `aa-variables.zsh` or `path.zsh`
- **New function related to git** → `git.zsh`
- **New function for a distinct new tool/app** → create a new `<topic>.zsh` file
- **New function that's miscellaneous** → `aliases.zsh` is fine for short ones; create a new file if it's substantial

## Conventions

- Use `alias` for one-liners; use `function` for anything with logic
- Group related aliases/functions together with a comment header
- Keep `aa-variables.zsh` pure exports so it stays fast and side-effect-free
- Alphabetical order within a file is nice to have but not required
