{ pkgs, ...}:

let
   hostName = builtins.getEnv "HOSTNAME";
   myAliases = {
       ll = "ls -l";
       ".." = "cd ..";
       g = "lazygit";
       cat = "bat";
       tx = "tmux attach";
       nvgd = "nvim --listen 127.0.0.1:55432";
	   fonts = "fc-list | grep -oP '(?<=: ).*'";
   };
in
{
    programs.zsh = {
        enable = true;
        shellAliases = myAliases;
        enableCompletion = true;
        oh-my-zsh = {
            enable = true;
            plugins = [
				"fzf"
            ];
        };
        syntaxHighlighting = {
            enable = true;
        };
        initExtra = ''  
            eval "$(zoxide init zsh)"

            bindkey -s '^f' "tmux-sessionizer\n"
			
			export DIRENV_LOG_FORMAT=""
			'';
		
    };
    programs.bash = {
        enable = true;
        shellAliases = myAliases;
        initExtra = ''  
            eval "$(zoxide init bash)"

            bindkey -s '^f' "tmux-sessionizer\n"
			export DIRENV_LOG_FORMAT=""
            '';
    };

#Shell scripts
    home.packages = with pkgs;[
        (writeShellScriptBin "rebuild" ''
         sudo nixos-rebuild switch --flake ~/dots/#${hostName}
         '')
		(writeShellScriptBin "testbuild" ''
		 sudo nixos-rebuild test --flake ~/dots/#${hostName} --option eval-cache false --show-trace
		 '')
    ];
}
