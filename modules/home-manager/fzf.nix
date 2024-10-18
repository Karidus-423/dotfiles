{ pkgs,...}:
{
    programs.fzf = {
		enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        tmux.enableShellIntegration = true;
        colors = {
            prompt = "#cabf44";
            hl = "#b2d498";
            "fg+" = "#cccccc";
        };
        defaultOptions = [
            "--height 50%"
            "--reverse"
            "--border=sharp"
            "--margin 5%"
            "--pointer=󰞘"
            "--color=label:#cccccc"
        ];
    };
    # Shell script name 
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    home.packages = with pkgs;[
        (writeShellScriptBin "tmux-sessionizer" ''

         if [[ $# -eq 1 ]]; then
         selected=$1
         else
         selected=$(find ~/ ~/.config ~/work ~/personal ~/personal/shaders ~/personal/advent -mindepth 1 -maxdepth 1 -type d | fzf --border-label=Sessionizer)
         fi

         if [[ -z $selected ]]; then
         exit 0
         fi

         selected_name=$(basename "$selected" | tr . _)
         tmux_running=$(pgrep tmux)

         if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
         tmux new-session -s $selected_name -c $selected
         exit 0
         fi

         if ! tmux has-session -t=$selected_name 2> /dev/null; then
             tmux new-session -ds $selected_name -c $selected
             tmux a
         fi

                 tmux switch-client -t $selected_name
        '')
    ];
}
