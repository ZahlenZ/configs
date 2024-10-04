# Download zinit if not
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux


# Completions
autoload -U compinit && compinit
zinit cdreplay -q
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# History
HISTSIZE=5000
HISTFILE=$XDG_DATA_HOME/zsh/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
LESSHIST=-1
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybinds
# bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Alias
alias ls='ls -a --color'
alias hx='helix'
alias c='clear'

# Shell integrations
eval "$(fzf --zsh)"

# Yazi helper function
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Source oh-my-posh keep last for now
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/custom_theme.json)"
