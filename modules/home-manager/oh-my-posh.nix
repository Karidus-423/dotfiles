{ config, pkgs, ... }:

{
  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    settings = builtins.fromJSON '' 
    {
    "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
    "blocks": [
        {
            "alignment": "left",
            "newline": true,
            "segments": [
                {
                    "background": "#c5c6c1",
                    "foreground": "#011627",
                    "leading_diamond": "\ue0b2",
                    "properties": {
                        "macos": "\uf179 ",
                        "ubuntu": "\uf31b ",
                        "windows": "\ue62a "
                    },
                    "style": "diamond",
                    "template": " {{ if .WSL }}WSL at {{ end }}{{.Icon}} ",
                    "trailing_diamond": "\ue0b0",
                    "type": "os"
                },
                {
                    "background": "#73b7b9",
                    "foreground": "#011627",
                    "leading_diamond": "\ue0b2",
                    "trailing_diamond": "\ue0b0",
                    "properties": {
                        "time_format": "\uf073 2 Jan, Monday "
                    },
                    "style": "diamond",
                    "template": "{{ .CurrentDate | date .Format }}",
                    "type": "time"
                },
                {
                    "background": "#696e48",
                    "foreground": "#011627",
                    "leading_diamond": "\ue0b2",
                    "properties": {
                        "branch_icon": "\ue725 ",
                        "fetch_stash_count": true,
                        "fetch_status": true,
                        "fetch_upstream_icon": true,
                        "fetch_worktree_count": true
                    },
                    "style": "diamond",
                    "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{if .BranchStatus }} {{ .BranchStatus }}{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Staging.Changed }} \uf046 {{ .Staging.String }}{{ end }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
                    "trailing_diamond": "\ue0b0",
                    "type": "git"
                }
            ],
            "type": "prompt"
        },
        {
            "alignment": "right",
            "segments": [
                {
                    "background": "#7d7b7b",
                    "foreground": "#d6deeb",
                    "leading_diamond": "\ue0b2",
                    "properties": {
                        "style": "roundrock",
                        "threshold": 0
                    },
                    "style": "diamond",
                    "template": " {{ .FormattedMs }} ",
                    "trailing_diamond": "\ue0b0",
                    "type": "executiontime"
                },
                {
                    "type": "cmake",
                    "leading_diamond": "\ue0b2",
                    "style": "diamond",
                    "trailing_diamond": "\ue0b0",
                    "foreground": "#E8EAEE",
                    "background": "#1E9748",
                    "template": " \ue61e \ue61d cmake {{ .Full }} "
                },
                {
                    "type": "python",
                    "leading_diamond": "\ue0b2",
                    "style": "diamond",
                    "trailing_diamond": "\ue0b0",
                    "properties": {
                        "display_mode": "context"
                    },
                    "foreground": "#011627",
                    "background": "#FFDE57",
                    "template": " \ue73c {{ if .Venv }}{{ .Venv }} {{ end }}{{ .Full }} "
                },
                {
                    "type": "go",
                    "leading_diamond": "\ue0b2",
                    "style": "diamond",
                    "trailing_diamond": "\ue0b0",
                    "foreground": "#ffffff",
                    "background": "#7FD5EA",
                    "template": " \u202d\ue626 {{ .Full }} "
                },
                {
                    "type": "rust",
                    "leading_diamond": "\ue0b2",
                    "style": "diamond",
                    "trailing_diamond": "\ue0b0",
                    "foreground": "#193549",
                    "background": "#99908A",
                    "template": " \ue7a8 {{ .Full }} "
                }
            ],
            "type": "prompt"
        },
        {
            "alignment": "left",
            "newline": true,
            "segments": [
                {
                    "style": "plain",
                    "template": "\u256d\u2500",
                    "type": "text"
                },
                {
                    "properties": {
                        "time_format": "15:04"
                    },
                    "style": "plain",
                    "template": " \u0394 {{ .CurrentDate | date .Format }} |",
                    "type": "time"
                },
                {
                    "style": "plain",
                    "template": " \uf292 ",
                    "type": "root"
                },
                {
                    "properties": {
                        "folder_icon": "\uf07b ",
                        "folder_separator_icon": " \uf061 ",
                        "home_icon": "\ueb06 "
                    },
                    "style": "plain",
                    "template": " {{ .Path }} ",
                    "type": "path"
                }
            ],
            "type": "prompt"
        },
        {
            "alignment": "left",
            "newline": true,
            "segments": [
                {
                    "foreground": "#D6DEEB",
                    "style": "plain",
                    "template": "\u2570\u2500",
                    "type": "text"
                },
                {
                    "foreground": "#D6DEEB",
                    "properties": {
                        "always_enabled": true
                    },
                    "style": "plain",
                    "template": "\u276f ",
                    "type": "status"
                }
            ],
            "type": "prompt"
        }
    ],
    "console_title_template": "{{ .Folder }}",
    "transient_prompt": {
        "background": "transparent",
        "foreground": "#c5c6c1",
        "template": "\ue285 "
    },
    "version": 2
}

    '';
  };
}
