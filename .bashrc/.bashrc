#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export PATH=$HOME/.local/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"


eval "$(starship init bash)"


# Fastfetch only if not a zed terminal
if [[ "$TERM_PROGRAM" != zed && -z "$ZED_TERM" ]]; then
	fastfetch
fi

# Auto-persist hyprpaper wallpaper

setwall() {
    local SRC="$(realpath --no-symlinks "$1")"
    local DEST="$HOME/dotfiles/wallpapers/current-wallpaper.jpg"

    # Check file exists
    if [[ ! -f "$SRC" ]]; then
        echo "Error: File '$SRC' does not exist."
        return 1
    fi

    # Replace the current wallpaper file
    cp -f "$SRC" "$DEST"
    
    {
        hyprctl hyprpaper wallpaper ",$DEST"
        wal -i "$SRC"
        ~/.config/waybar/scripts/launch.sh & disown
        :
    } >/dev/null 2>&1

    echo "Wallpaper updated → $SRC"
}

[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"
