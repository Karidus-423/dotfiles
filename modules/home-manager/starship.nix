{...}:
{
	programs.starship = {
		enable = true;
		enableBashIntegration = true;
		enableZshIntegration = true;
	};
		home.file.".config/starship.toml".text = ''
add_newline = false
format = """ 
$hostname$directory$git_branch$git_status$php$rust$golang$nix_shell
$linebreak$character
"""
command_timeout = 2000

[directory]
format = "[  ](bold grey)[$path ](#b3dcdd)[$read_only|]($read_only_style #acafad) "
truncation_length = 2
home_symbol = " 󱄫 "

[character]
success_symbol = "[󰇂 ](green)"
error_symbol = "[󰇂 ](red)"
vicmd_symbol = "[« ](green)"

[git_branch]
symbol = " "
format = "[$symbol$branch ](#717C7C)"
# ~/.config/starship.toml

[git_status]
conflicted = ' 󰈿 '
up_to_date = ' ✓ '
untracked = ' 󰃹 '
stashed = ' 󰩪 '
modified = ' 󰷥 '
staged = ' [++\($count\)](green)'
renamed = ' 󰮆 '
ahead = '⇡ $count '
diverged = ' ⇕⇡ $ahead_count -⇣ $behind_count '
behind = ' ⇣ $count'
style = 'bold #e8eda2'

[nix_shell]
symbol = "  "
[php]
symbol = ""
format = '[[ $symbol ($version) ](fg:#af9ff0)]($style)'
[rust]
symbol = ""
format = '[[ $symbol ($version) ](fg:#c37937)]($style)'
[golang]
symbol = ""
format = '[[ $symbol ($version) ](fg:#6094d3)]($style)'
[c]
symbol = ""
format = '[[ $symbol ($version) ](fg:#938056)]($style)'
[zig]
symbol = ""
format = '[[ $symbol ($version) ](fg:#DCA561)]($style)'
'';
}
