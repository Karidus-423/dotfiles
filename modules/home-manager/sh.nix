{ config, pkgs, ...}:

let
   myAliases = {
     ll = "ls -l";
     ".." = "cd ..";
     g = "lazygit";
     cat = "bat";
     tx = "tmux attach";
     mh = "man home-configuration.nix";
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
            bindkey -s '^f' "tmux-sessionizer\n"
        '';
	};
    programs.bash = {
        enable = true;
        shellAliases = myAliases;
    };

    #Shell scripts
    home.packages = with pkgs;[
        (writeShellScriptBin "rebuild" ''
        #!/bin/bash
        sudo nixos-rebuild switch --flake ~/dots/#icarus
        '')
    ];
}
