{ config, pkgs, ...}:

let
   myAliases = {
     ll = "ls -l";
     ".." = "cd ..";
     "g" = "lazygit";
     "cat" = "bat";
     "rebuild" = "nixos-rebuild";
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
        (writeShellScriptBin "nixos-rebuild" ''
        #!/bin/bash
         set -e
         pushd ~/dots
         git add .
         sudo nixos-rebuild switch --flake ~/dots/#icarus
         current=$(nixos-rebuild list-generations | grep current)
        # Commit all changes witih the generation metadata
         git commit -am "$current"
        # Back to where you were
         popd
        # Notify all OK!
         notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
        '')
    ];
}
