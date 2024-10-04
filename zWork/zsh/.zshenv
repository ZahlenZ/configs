export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"
export EDITOR="helix"
export PATH="$PATH:$HOME/.local/bin:$HOME/go/bin:$HOME/code/script"

dirs=(
  "$XDG_CONFIG_HOME"
  "$XDG_CACHE_HOME"
  "$XDG_DATA_HOME"
  "$XDG_STATE_HOME"
)

for dir in "${dirs[@]}"; do
  [ -d "$dir" ] || mkdir -p "$dir"
done
