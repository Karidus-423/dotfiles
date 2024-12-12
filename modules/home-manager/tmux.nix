{ pkgs, ...}:
{
	programs.tmux = {
		enable = true;
		baseIndex = 1;
        newSession = false;
		mouse = true;
		prefix = "C-Space";
		shell = "${pkgs.zsh}/bin/zsh";
        keyMode = "vi";
        plugins = with pkgs; [
          tmuxPlugins.better-mouse-mode
          tmuxPlugins.vim-tmux-navigator
          tmuxPlugins.sensible
          tmuxPlugins.yank
        ];
        extraConfig = "
		set -ga terminal-overrides '*:Ss=\\E\[%p1%d q:Se=\\E\[ q'
		set-option -a terminal-features 'XXX:RGB'
		set -g status-justify left \n
		set -as terminal-overrides \",screen-256color*:Tc\" \n
        bind c new-window -c \"#{pane_current_path}\" \n
		set -g allow-passthrough all \n
		set -ga update-environment TERM \n
		set -ga update-environment TERM_PROGRAM \n
        set-option -g renumber-windows on \n
        set -g window-status-separator \"\" \n
		set -g status-style 'bg=#cccccc fg=#9a9a9a' \n
		set -g window-status-format \"#[fg=#cccccc,bg=#cccccc,nobold,noitalics,nounderscore] #[fg=#9a9a9a,bg=#cccccc]#I #[fg=#9a9a9a,bg=#cccccc,nobold,noitalics,nounderscore] #[fg=#9a9a9a,bg=#cccccc]#W #[fg=#cccccc,bg=#cccccc,nobold,noitalics,nounderscore]\"\n
		set -g window-status-current-format \"#[fg=#cccccc,bg=#9a9a9a,nobold,noitalics,nounderscore] #[fg=#cccccc,bg=#9a9a9a]#I #[fg=#cccccc,bg=#9a9a9a,nobold,noitalics,nounderscore] #[fg=#cccccc,bg=#9a9a9a]#W #[fg=#cccccc,bg=#9a9a9a,nobold,noitalics,nounderscore]\" \n
		set-window-option -g window-status-activity-style bg=colour237,fg=colour248 # bg=bg1, fg=fg3
	    set-option -g status-right-style 'bg=#9a9a9a fg=#cccccc' \n
        set-option -g status-right-length \"80\" \n
		bind-key -r f run-shell \"tmux neww ~/.nix-profile/bin/tmux-sessionizer\" \n
		bind-key t run-shell \"tmux neww -n yazi ${pkgs.yazi}/bin/yazi\"
		bind-key -r u run-shell \"tmux neww ~/.nix-profile/bin/tmux-sessionizer ~/notes\" \n
        ";
    };
}
