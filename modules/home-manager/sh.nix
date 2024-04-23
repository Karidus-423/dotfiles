{ config, pkgs, ...}:

let
   myAliases = {
       cl = "clear";
       ll = "ls -l";
       ".." = "cd ..";
       g = "lazygit";
       cat = "bat";
       tx = "tmux attach";
       mh = "man home-configuration.nix";
	   pyvenv = "python -m venv .venv";
       dev = "nix develop --command zsh";
	   venv = "source .venv/bin/activate";
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
				"fzf"
            ];
        };
        syntaxHighlighting = {
            enable = true;
        };
        initExtra = ''  
            eval "$(zoxide init zsh)"

            bindkey -s '^f' "tmux-sessionizer\n"
            bindkey -s '^c' "bye"

                    '';
    };
    programs.bash = {
        enable = true;
        shellAliases = myAliases;
        initExtra = ''  
            eval "$(zoxide init bash)"

            bindkey -s '^f' "tmux-sessionizer\n"
            bindkey -s '^c' "bye"
            '';
    };

#Shell scripts
    home.packages = with pkgs;[
        (writeShellScriptBin "rebuild" ''
         sudo nixos-rebuild switch --flake ~/dots/#icarus
         '')
        (writeShellScriptBin "testbuild" ''
         sudo nixos-rebuild test --flake ~/dots/#icarus
         '')
    ];
}
