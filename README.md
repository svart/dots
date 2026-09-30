# dots

Dotfiles, deployed into `~` with GNU Stow. The repo root is the stow
package; it lives at `~/work/dots`.

## Install / update

Always stow with `--no-folding`:

```bash
stow --no-folding -d ~/work -t ~ -R dots
```

Without `--no-folding`, stow symlinks whole directories (e.g.
`~/.local/bin -> work/dots/.local/bin`). Tools then write their own
files — binaries, plugins, fish state — into the repo.

Preview changes first with `-n -v`:

```bash
stow -n -v --no-folding -d ~/work -t ~ -R dots
```

Remove all links:

```bash
stow -d ~/work -t ~ -D dots
```

## Ignored by stow

`.stow-local-ignore` at the repo root lists paths that are never
linked. Stow reads only this root file; nested `.stow-local-ignore`
files have no effect. Defining it also disables stow's built-in ignore
list, so repo-only files like this README must be listed there.

## Not tracked

Machine-local state stays in `~` and is not committed:

- `~/.config/fish/fish_variables` — fish universal variables
- `~/.config/tmux/plugins/` — installed by TPM
- `~/.doom.d/custom.el` — Emacs Custom output
- binaries and installer symlinks in `~/.local/bin`
