# ~/.zshrc — Yozakura (夜桜) setup, 2026-10-05.
#
# Source of truth: /mnt/c/Users/asfan/Desktop/Personal/zsh_config_prompt
# Edit there and run ./install.sh, or edit ~/.zshrc directly and copy back.
# The original wizard-generated files are in backup/ in that folder.

# ---- powerlevel10k instant prompt -------------------------------------------------------------
# Must stay near the top. Anything that prints or asks for input goes above it.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ---- environment ------------------------------------------------------------------------------
export LANG=${LANG:-C.UTF-8}
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export LESS='-R -i -F -X -M'
export COLORTERM=truecolor

# Android NDK (carried over from .bashrc)
export ANDROID_NDK_HOME=/opt/android-ndk
export ANDROID_NDK_ROOT=$ANDROID_NDK_HOME

# PATH without duplicates. Entries earlier in the list win.
typeset -U path PATH
path=(
  $HOME/.local/bin
  $ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin
  $path
)

# ---- Oh My Zsh --------------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14
HIST_STAMPS="yyyy-mm-dd"

# nvm is loaded on first use of nvm/node/npm/npx instead of at startup (saves ~0.35 s).
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' lazy-cmd node npm npx yarn pnpm

plugins=(
  git                     # g* aliases: gst, gco, gd, glog, ...
  fzf                     # Ctrl-R history, Ctrl-T files, Alt-C cd, ** completion
  sudo                    # press Esc twice to prefix the line with sudo
  extract                 # `extract foo.tar.xz` for any archive
  colored-man-pages
  command-not-found
  nvm                     # lazy, see zstyle above
  zsh-autosuggestions     # grey ghost text from history; → or End accepts
  zsh-syntax-highlighting # must be the last plugin
)

source "$ZSH/oh-my-zsh.sh"

# ---- prompt -----------------------------------------------------------------------------------
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---- history ----------------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY          # record timestamp and duration
setopt INC_APPEND_HISTORY        # write as you go, not on exit
setopt SHARE_HISTORY             # one history across all open terminals
setopt HIST_IGNORE_ALL_DUPS      # keep only the newest copy of a repeated command
setopt HIST_IGNORE_SPACE         # a leading space keeps a command out of history
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY               # show the expanded !! line before running it

# ---- shell options ----------------------------------------------------------------------------
setopt AUTO_CD                   # type a directory name to cd into it
setopt AUTO_PUSHD                # cd keeps a stack; `cd -<Tab>` lists it
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt INTERACTIVE_COMMENTS      # allow # comments on the command line
setopt NO_BEEP
unsetopt FLOW_CONTROL            # free Ctrl-S / Ctrl-Q

# ---- Yozakura palette for everything that is not the prompt ----------------------------------
# sakura #e8a4b8  plum #b58bb3  gold #d4a373  moon #8a9bc4  moss #8fa882
# rose   #c9697f  teal #8fb3b0  mist #8a7d8a  dusk #5c525e  ash  #4a3f4a

# ls / completion colours (24-bit). ow/tw cover the 777 directories under /mnt/c,
# which otherwise show as green text on a blue block.
export LS_COLORS='rs=0:di=1;38;2;138;155;196:ow=1;38;2;138;155;196:tw=1;38;2;138;155;196:st=1;38;2;138;155;196:ln=38;2;181;139;179:or=38;2;201;105;127:mi=38;2;201;105;127:ex=38;2;143;168;130:so=38;2;212;163;115:pi=38;2;212;163;115:bd=38;2;212;163;115:cd=38;2;212;163;115:su=1;38;2;201;105;127:sg=1;38;2;201;105;127:*.tar=38;2;143;179;176:*.tgz=38;2;143;179;176:*.gz=38;2;143;179;176:*.xz=38;2;143;179;176:*.zst=38;2;143;179;176:*.zip=38;2;143;179;176:*.7z=38;2;143;179;176:*.rar=38;2;143;179;176:*.deb=38;2;143;179;176:*.apk=38;2;143;179;176:*.img=38;2;143;179;176:*.iso=38;2;143;179;176:*.png=38;2;181;139;179:*.jpg=38;2;181;139;179:*.jpeg=38;2;181;139;179:*.gif=38;2;181;139;179:*.webp=38;2;181;139;179:*.svg=38;2;181;139;179:*.mp4=38;2;181;139;179:*.mkv=38;2;181;139;179:*.mp3=38;2;181;139;179:*.pdf=38;2;212;163;115:*.md=38;2;216;207;214:*.txt=38;2;216;207;214:*.log=38;2;92;82;94:*.bak=38;2;92;82;94:*.tmp=38;2;92;82;94:*~=38;2;92;82;94'

# completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{#b58bb3}── %d ──%f'
zstyle ':completion:*:messages'     format '%F{#d4a373}%d%f'
zstyle ':completion:*:warnings'     format '%F{#c9697f}no matches for %d%f'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#4a3f4a'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40

# syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_STYLES[default]='none'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#c9697f'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#b58bb3'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#8fa882'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#8fa882'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#8fa882'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#8fa882'
ZSH_HIGHLIGHT_STYLES[function]='fg=#8fa882'
ZSH_HIGHLIGHT_STYLES[command]='fg=#8fa882'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#8fa882'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#8fa882,italic'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#8fa882'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#b58bb3'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#b58bb3'
ZSH_HIGHLIGHT_STYLES[path]='fg=#d8cfd6,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#d8cfd6,underline'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#8a7d8a,underline'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#8a7d8a,underline'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#8a9bc4'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#8a9bc4'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#8a9bc4'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#8a9bc4'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#d4a373'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#d4a373'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#d4a373'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#d4a373'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#8fb3b0'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#8fb3b0'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#8fb3b0'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#8fb3b0'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#8fb3b0'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#8fb3b0'
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#8fb3b0'
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#8fb3b0'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#5c525e'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=#b58bb3'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=#8a9bc4'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=#d4a373'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=#8fb3b0'
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=#c9697f'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='standout'

# fzf
export FZF_DEFAULT_OPTS="--height 45% --layout=reverse --border=rounded --info=inline --prompt='❯ ' --pointer='❀' --marker='✱' --color=bg:#0b0a0d,bg+:#1a171c,fg:#8a7d8a,fg+:#d8cfd6,hl:#b58bb3,hl+:#e8a4b8,info:#d4a373,prompt:#e8a4b8,pointer:#e8a4b8,marker:#8fa882,spinner:#e8a4b8,header:#b58bb3,border:#4a3f4a,gutter:#0b0a0d"
if (( $+commands[rg] )); then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# ---- key bindings -----------------------------------------------------------------------------
bindkey -e
bindkey '^H'      backward-kill-word   # Ctrl-Backspace
bindkey '^[[3;5~' kill-word            # Ctrl-Delete
bindkey '^[[1;5C' forward-word         # Ctrl-Right
bindkey '^[[1;5D' backward-word        # Ctrl-Left

# ---- aliases ----------------------------------------------------------------------------------
alias ll='ls -alFh'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias reload='exec zsh'
alias zshrc='${EDITOR} ~/.zshrc'
alias p10krc='${EDITOR} ~/.p10k.zsh'
# WSL niceties
alias open='explorer.exe'        # `open .` opens the current folder in Explorer
alias clip='clip.exe'            # `cmd | clip` copies to the Windows clipboard
alias winhome='cd /mnt/c/Users/asfan'

# ---- nvm ---------------------------------------------------------------------------------------
# Loaded lazily by the Oh My Zsh nvm plugin (zstyle near the top). NVM_DIR is all it needs here.
export NVM_DIR="$HOME/.nvm"
