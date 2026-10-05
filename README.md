# Yozakura 夜桜 — zsh / tmux / Windows Terminal

Dark sakura setup for WSL Ubuntu in Windows Terminal. Near-black background,
dusty rose and plum accents, moonlit blue-grey for directories.

```
~/Desktop/Personal/zsh_config_prompt ❀ master +1 !5 ?9            ✘ 1 · 21:04
❯
```

## Files

| file | installed to | what |
|---|---|---|
| `zshrc` | `~/.zshrc` | Oh My Zsh, plugins, history, completion, fzf, LS_COLORS, syntax colours, aliases |
| `p10k.zsh` | `~/.p10k.zsh` | lean two-line powerlevel10k prompt, transient prompt, Nerd Font v3 |
| `tmux.conf` | `~/.tmux.conf` | matching status bar, vi copy mode, clipboard to Windows |
| `vim/vimrc`, `vim/colors/yozakura.vim` | `~/.vimrc`, `~/.vim/colors/` | truecolor Yozakura colorscheme, cursorline, bar cursor in insert mode |
| `windows-terminal/yozakura.json` | WT `settings.json` → `schemes` | the 16-colour scheme |
| `windows-terminal/apply.py` | | adds the scheme and sets the Ubuntu profile (font, cursor, padding) |
| `install.sh` | | copies everything above into place, backs up what it replaces |
| `backup/` | | the wizard-generated files from before 2026-10-05 |

Re-apply after editing anything here:

```sh
./install.sh
```

Or edit `~/.zshrc` / `~/.p10k.zsh` directly and copy them back here.

## Palette

| name | hex | used for |
|---|---|---|
| bg | `#0b0a0d` | terminal background |
| fg | `#d8cfd6` | normal text |
| sakura | `#e8a4b8` | prompt char, directory anchor, cursor, active tmux window |
| plum | `#b58bb3` | git branch, separators, keywords |
| gold | `#d4a373` | modified files, strings, execution time, root |
| moon | `#8a9bc4` | directories, flags, untracked files |
| moss | `#8fa882` | valid commands, success |
| rose | `#c9697f` | errors, bad commands |
| teal | `#8fb3b0` | variables, substitutions |
| mist | `#8a7d8a` | path text |
| dusk | `#5c525e` | clock, comments |
| ash | `#4a3f4a` | autosuggestion ghost text |

## Keys worth knowing

| key | does |
|---|---|
| `Ctrl-R` | fuzzy history search (fzf) |
| `Ctrl-T` | fuzzy file picker into the command line |
| `Alt-C` | fuzzy cd |
| `→` or `End` | accept the grey autosuggestion |
| `Esc Esc` | prefix the line with `sudo` |
| `Ctrl-Backspace` / `Ctrl-Delete` | delete word left / right |
| `cd -<Tab>` | pick from the directory stack |
| `extract file.tar.xz` | unpack any archive |
| `open .` | open the folder in Explorer |
| `cmd \| clip` | copy to the Windows clipboard |

tmux (prefix `Ctrl-b`): `|` and `-` split, `h j k l` move between panes,
`H J K L` resize, `r` reload config, `v` then `y` in copy mode copies to Windows.

## Notes

- Font: JetBrainsMono Nerd Font 3.3.0, installed with
  `winget install DEVCOM.JetBrainsMonoNerdFont`. Tabs opened before the install
  keep the old font until reopened.
- Startup is about 0.2 s. nvm is loaded lazily by the Oh My Zsh nvm plugin on
  the first `nvm`, `node`, `npm`, `npx`, `yarn` or `pnpm` call.
- `ls` colours use 24-bit escapes; `/mnt/c` directories (mode 777) no longer
  render as green on blue.
