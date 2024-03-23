{ config, pkgs, ...}:

let
   myAliases = {
     ll = "ls -l";
     ".." = "cd ..";
     g = "lazygit";
     cat = "bat";
     tx = "tmux attach";
     mh = "man home-configuration.nix";
     dev = "nix develop --command zsh";
     nvgd = "nvim --listen 127.0.0.1:55432";
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
                "ripgrep"
            ];
        };
        syntaxHighlighting = {
            enable = true;
        };
        initExtra = ''  
            eval "$(zoxide init zsh)"

            bindkey -s '^f' "tmux-sessionizer\n"
            bindkey -s '^c' "bye"
            

            if [ -n "$\{commands[fzf-share]\}" ]; then
              source "$(fzf-share)/key-bindings.zsh"
              source "$(fzf-share)/completion.zsh"
            fi

        '';
	};
    programs.bash = {
        enable = true;
        shellAliases = myAliases;
        initExtra = ''  
            eval "$(zoxide init zsh)"

            bindkey -s '^f' "tmux-sessionizer\n"
            bindkey -s '^c' "bye"
        '';
    };

    #Shell scripts
    home.packages = with pkgs;[
        (writeShellScriptBin "rebuild" ''
        sudo nixos-rebuild switch --flake ~/dots/#icarus
        '')
    ];
}
