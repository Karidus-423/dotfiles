# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kennett/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Start OH-MY-POSH
eval "$(oh-my-posh init zsh --config ~/.config/ohmyposh/karidus.omp.json)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Aliases Git
alias g="lazygit"

#Aliases Window Manager
alias toggle="swaymsg output eDP-1 toggle"

#Aliases Productivity
alias tx="tmux attach"

#Vim Settings
bindkey -v

function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] || [[ $1 == 'block' ]]; then
        echo -ne '\e[1 q'  # Block cursor for normal mode
    elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ $1 == 'line' ]]; then
        echo -ne '\e[5 q'  # Line (I-beam) cursor for insert mode
    elif [[ ${KEYMAP} == visual ]] || [[ $1 == 'underline' ]]; then
        echo -ne '\e[4 q'  # Underline cursor for visual mode
    fi
}
zle -N zle-keymap-select

echo -ne '\e[5 q'  # Default to line cursor, adjust if desired


