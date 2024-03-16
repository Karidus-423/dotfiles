{ config, pkgs, ...}:
{
	programs.tmux = {
		enable = true;
		baseIndex = 1;
		mouse = true;
		prefix = "C-Space";
		shell = "${pkgs.zsh}/bin/zsh";
		terminal = "alacritty";
		extraConfig = "
        bind c new-window -c \"#{pane_current_path}\" \n
        set-option -g renumber-windows on \n
        ";
		newSession = false;
        plugins = with pkgs; [
          tmuxPlugins.better-mouse-mode
          tmuxPlugins.nord
          tmuxPlugins.sensible
          tmuxPlugins.vim-tmux-navigator
          tmuxPlugins.yank
        ];
	};
}
