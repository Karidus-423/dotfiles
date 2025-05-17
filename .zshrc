# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/karidus/.zshrc'
autoload -Uz compinit
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include .files
# End of lines added by compinstall
#

export PATH=$PATH:$HOME/.local/bin:$HOME/.local/scripts:$HOME/.cargo/bin
export DIRENV_LOG_FORMAT=""
export FZF_DEFAULT_OPTS="
--height 50% --reverse --border=sharp --margin 5% --color=label:white"
export MANPAGER="nvim +Man!"
export EDITOR="nvim"
# Set up fzf key bindings and fuzzy completion

source <(fzf --zsh)

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

#Vim Mode
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey -s '^f' "tmux-sessionizer\n"

# Removing Keys
bindkey -r '^[[KP_Add'



alias g=lazygit
alias fonts="fc-list | grep -oP '(?<=: ).*'";
alias nvgd="nvim --listen 127.0.0.1:55432";
alias tx="tmux attach"
alias cat=bat
alias ll="ls -l"


# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=$PATH:/home/kennett/.spicetify
