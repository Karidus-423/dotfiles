{ config, pkgs, ...}:
{
	programs.tmux = {
		enable = true;
		baseIndex = 1;
		mouse = true;
		prefix = "C-Space";
		shell = "${pkgs.zsh}/bin/zsh";
		terminal = "screen-256color";
		extraConfig = "bind c new-window -c \"#{pane_current_path}\"";
		newSession = true;
        plugins = with pkgs; [
          tmuxPlugins.better-mouse-mode
          tmuxPlugins.nord
          tmuxPlugins.sensible
          tmuxPlugins.vim-tmux-navigator
        ];
	};
}
