{...}:
{
programs.waybar = {
	enable = true;
	settings =[{
		position = "top";
		height = 20;
		modules-center =[
			"hyprland/workspaces"
		];
        modules-left = [
            "network"
            "pulseaudio"
        ];
        modules-right = [
            "clock"
            "battery"
        ];
		"hyprland/workspaces" = {
			disable-scroll = true;
			all-outputs = true;
			format = "{icon}";
			persistent-workspaces = {
				"1" = [];
				"2" = [];
				"3" = [];
				"4" = [];
				"5" = [];
				"6" = [];
			};
			format-icons = {
				"1" = "";
				"2" = "󰈹";
				"3" = "󱉟";
				"4" = "";
				"5" = "";
				"6" = "󰽰";
			};
		};
		"clock" = {
			format = ''{: %I:%M %p}'';
			on-click = "alacritty -e calcure";
		};
		"battery" = {
			states = {
				warning = 30;
				critical = 15;
			};
			format = "{icon} {capacity}%";
			format-charging = "󰂄 {capacity}%";
			format-plugged = "󱘖 {capacity}%";
			format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
			on-click = "";
			tooltip = false;
		};
		"network" = {
			format-wifi = " ";
			format-ethernet = "󰈀 ";
			format-linked = "{ifname} (No IP) ";
			format-disconnected = "󰤮 ";
			tooltip-format-wifi = "Signal Strenght: {signalStrength}% | Down Speed: {bandwidthDownBits}, Up Speed: {bandwidthUpBits}";
		};
		"pulseaudio" = {
			format = "{icon} {volume}%";
			format-bluetooth = "{volume}% {icon} {format_source}";
			format-bluetooth-muted = " {icon} {format_source}";
			format-muted = " {format_source}";
			format-icons = {
				headphone = "";
				hands-free = "";
				headset = "";
				phone = "";
				portable = "";
				car = "";
				default = ["" "" ""];
			};
			on-click = "sleep 0.1 && pavucontrol";
		};
        "cava" = {
            framerate = 60;
            bars = 12;
            sensitivity = 80;
        };



	}];
	style = '' 
	#custom-date,
	#clock,
	#battery,
	#pulseaudio,
	#network {
		border: none;
		border-radius: 0;
		font-family: "GohuFont uni11 Nerd Font";
		font-size: 12px;
		min-height: 0;
	}

	window#waybar {
	background: transparent;
	color: #BCBFBA;
	}

	tooltip {
	background: #4B4B4B;
		    border-width: 2px;
		    border-style: solid;
		    border-color: #262626;
	}

	#workspaces button {
	padding: 5px 10px;
	color: #CCCCCC;
	}

	#workspaces button.active {
	color: #4B4B4B;
	       background-color: #527FB5;
	}

	#workspaces button:hover {
		background-color: #527FB5;
	color: #4B4B4B;
	}

	#custom-date,
	#clock,
	#battery,
	#pulseaudio,
	#network,
    #window,
	#workspaces {
		background-color: #4B4B4B;
	padding: 5px 10px;
	margin: 5px 0px;
	}

	#workspaces {
		background-color: #4B4B4B;
        border-radius: 5px;
		font-family: "Mononoki Nerd Font Mono";
		font-size: 20px
	}

	#custom-date {
	color: #9ec3c4;
	}

	#clock {
	color: #B489C2;
	       border-radius: 0px 3px 3px 0px;
	}

	#battery {
       color: #819E69;
       margin-right: 5px;
	}

	#battery.charging {
	color: #B2D498;
	}

	#battery.warning:not(.charging) {
		background-color: #BA6D6D;
	color: #4B4B4B;
	}

	#network {
	color: #B4A71D;
	border-radius: 3px 0px 0px 3px;
    margin-left: 5px;
	}

	#pulseaudio {
	color: #75BCBD;
	}

	''
	;
	};
	}
