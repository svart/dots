# dots

Dotfiles, deployed into `~` with GNU Stow. The repo root is the stow
package; the repo can live anywhere. Run all commands below from the
repo root.

## Install / update

```bash
stow -R .
```

Stow options come from `.stowrc` in the repo root, which stow reads
from the current directory: `--target=~` and `--no-folding`.

Without `--no-folding`, stow symlinks whole directories (e.g.
`~/.local/bin` pointing into the repo). Tools then write their own
files — binaries, plugins, fish state — into the repo.

Preview changes first:

```bash
stow -n -v -R .
```

Remove all links:

```bash
stow -D .
```

## Ignored by stow

`.stow-local-ignore` at the repo root lists paths that are never
linked. Stow reads only this root file; nested `.stow-local-ignore`
files have no effect. Defining it also disables stow's built-in ignore
list, so repo-only files like this README and `.stowrc` must be
listed there.

## Not tracked

Machine-local state stays in `~` and is not committed:

- `~/.config/fish/fish_variables` — fish universal variables
- `~/.config/tmux/plugins/` — installed by TPM
- `~/.doom.d/custom.el` — Emacs Custom output
- binaries and installer symlinks in `~/.local/bin`
