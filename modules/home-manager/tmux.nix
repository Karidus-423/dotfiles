{ pkgs, ...}:
{
	programs.tmux = {
		enable = true;
		baseIndex = 1;
        newSession = false;
		mouse = true;
		prefix = "C-Space";
        terminal = "screen-256color";
		shell = "${pkgs.zsh}/bin/zsh";
        keyMode = "vi";
        plugins = with pkgs; [
          tmuxPlugins.better-mouse-mode
          tmuxPlugins.sensible
          tmuxPlugins.vim-tmux-navigator
          tmuxPlugins.yank
        ];
        extraConfig = "
        set -g status-style 'bg=#cccccc fg=#80652b' \n
        set -g status-justify left \n
        bind c new-window -c \"#{pane_current_path}\" \n
        set-option -g renumber-windows on \n
        set -g window-status-format \"#[fg=#cccccc,bg=#cccccc,nobold,noitalics,nounderscore] #[fg=#80652b,bg=#cccccc]#I #[fg=#80652b,bg=#cccccc,nobold,noitalics,nounderscore] #[fg=#80652b,bg=#cccccc]#W #[fg=#cccccc,bg=#cccccc,nobold,noitalics,nounderscore]\"\n
        set -g window-status-current-format \"#[fg=#cccccc,bg=#80652b,nobold,noitalics,nounderscore] #[fg=#cccccc,bg=#80652b]#I #[fg=#cccccc,bg=#80652b,nobold,noitalics,nounderscore] #[fg=#cccccc,bg=#80652b]#W #[fg=#cccccc,bg=#80652b,nobold,noitalics,nounderscore]\" \n
        set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3
        set -g window-status-separator \"\" \n
        set-option -g status-right-style 'bg=#80652b fg=#cccccc' \n
        set-option -g status-right-length \"80\" \n
        ";
    };
}
