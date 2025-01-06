# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/karidus/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
#

export PATH=$PATH:/home/karidus/.local/bin:/home/karidus/.local/scripts
export DIRENV_LOG_FORMAT=""
export FZF_DEFAULT_OPTS="
--height 50% --reverse --border=sharp --margin 5% --color=label:#cccccc"
export MANPAGER="nvim +Man!"
# Set up fzf key bindings and fuzzy completion

source <(fzf --zsh)

eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"

bindkey -v
bindkey -s '^f' "tmux-sessionizer\n"


alias g=lazygit
alias fonts="fc-list | grep -oP '(?<=: ).*'";
alias nvgd="nvim --listen 127.0.0.1:55432";
alias tx="tmux attach"
alias cat=bat
alias ll="ls -l"


