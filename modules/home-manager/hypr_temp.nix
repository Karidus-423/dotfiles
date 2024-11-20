{pkgs, lib, config, ...}:
let 
	startupScript = pkgs.writeShellScriptBin "start" ''
	${pkgs.swww}/bin/swww-daemon &
	${pkgs.swww}/bin/swww init &

	sleep 1 

	${pkgs.ags}/bin/ags &

	sleep 1

	${pkgs.swww}/bin/swww img ${config.hyprlandWallpaper} --transition-type=grow &
	${pkgs.gammastep}/bin/gammastep &
	pipewire-pulse &

	sleep 1
	${pkgs.openrgb}/bin/openrgb -c 9F1C02

	sleep 1
	${pkgs.wlr-randr}/bin/wlr-randr --output DP-2 --custom-mode 3440x1440@165.00
	'';



	inherit (lib) mkOption types;
in
{
	config = {
		wayland.windowManager.hyprland = {
			enable = true;

			settings = {
				exec-once = ''${startupScript}/bin/start'';

				decoration = {
					rounding = "5";
				};

				general = config.hyprlandGeneral;

				monitor = config.hyprlandMonitors;
			};

			extraConfig = ''
		# Set programs that you use
		$terminal = foot
		$fileManager = foot -e lf
		$menu = ags -t applauncher -b ags
		$browser = firefox
		$notebook = obsidian

		# Some default env vars.
        env = GDK_SCALE,1
		env = XCURSOR_SIZE,24
		env = QT_QPA_PLATFORMTHEME,qt5ct # change to qt6ct if you have that
		env = QT_AUTO_SCREEN_SCALE_FACTOR,1
		env = XDG_SESSION_TYPE,wayland

		cursor {
			no_hardware_cursors = true
		}

        xwayland {
            force_zero_scaling = true
        }
		# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
		input {
		    kb_layout = us
		    kb_variant =
		    kb_model =
		    kb_options =
		    kb_rules =

		    follow_mouse = 1

		    touchpad {
			natural_scroll = no
		    }

		    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
		}

		decoration {
		    # See https://wiki.hyprland.org/Configuring/Variables/ for more

		    rounding = 5
		    
		    blur {
			enabled = false
		    }

			
		}

		animations {
		    enabled = yes

		    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

		    bezier = waitup, 0.92, 1.66, 0.94, 0.22 
		    bezier= linear, .17,.67,.83,.67
		    bezier= foosh,.17,.7,.1,.85
            bezier= breath,0.0,1.0,1.0,0.0

		    animation = windowsIn, 1, 4, foosh, slide
		    animation = windowsOut, 1, 3, foosh, slide
            animation = windowsMove, 1, 3, foosh
		    animation = border, 1, 3, waitup
		    animation = borderangle, 1, 150, breath, loop
            animation = fade, 1, 3, default
		    animation = workspaces, 0, 3, foosh, slide
		}

		dwindle {
		    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
		    pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
		    preserve_split = true # you probably want this
            force_split = 2
		}


		gestures {
		    # See https://wiki.hyprland.org/Configuring/Variables/ for more
		    workspace_swipe = on
		}

		misc {
		    # See https://wiki.hyprland.org/Configuring/Variables/ for more
		    force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
		    vfr = true
		}

		# Example per-device config
		# See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
		#device:epic-mouse-v1 {
		#    sensitivity = -0.5
		#}

		# Example windowrule v1
		# windowrule = float, ^(kitty)$
		# Example windowrule v2
		# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
		# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
		#windowrulev2 = nomaximizerequest, class:.* # You'll probably like this.


		# See https://wiki.hyprland.org/Configuring/Keywords/ for more
		$mainMod = SUPER

		# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
		bind = $mainMod, RETURN, exec, $terminal
		bind = $mainMod, Q, killactive, 
		bind = $mainMod_SHIFT, Q, exit, 
		bind = $mainMod, S, exec, $menu
		bind = $mainMod, E, exec, $filemanager
		bind = $mainMod, F, exec, $browser
		bind = $mainMod, V, togglefloating, 
		bind = $mainMod, P, pseudo, # dwindle
		bind = $mainMod, D, togglesplit, # dwindle
		bind = , Menu, exec, pavucontrol
        bind = , Print,exec,grim -g "$(slurp -w 0 -b cccccc7a)" - | swappy -f -


        #Status Bar Refresh
        bind = , XF86Display,exec, ags -q && ags

        #Brightness
        binde = , XF86MonBrightnessDown,exec,brightnessctl set 5%-
        binde = , XF86MonBrightnessUp,exec,brightnessctl set 5%+

        #Audio
		binde = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
		binde = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
		bindl = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
		bind = , XF86AudioPlay, exec, playerctl play-pause
		bind = , XF86AudioPrev, exec, playerctl previous
		bind = , XF86AudioPause, exec, playerctl pause
		bind = , XF86AudioNext, exec, playerctl next

		# trigger when the switch is toggled
		#bindl=,switch:[switch name],exec,swaylock
		#
		# trigger when the switch is turning on
		bindl=,switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1, disable" && ags -q && ags
		# trigger when the switch is turning off
		bindl=,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1, highres,auto,1.5" && ags -q && ags


		# Move focus with mainMod + arrow keys
		bind = $mainMod, h, movefocus, l
		bind = $mainMod, l, movefocus, r
		bind = $mainMod, k, movefocus, u
		bind = $mainMod, j, movefocus, d

		# Switch workspaces with mainMod + [0-9]
		bind = $mainMod, 1, workspace, 1
		bind = $mainMod, 2, workspace, 2
		bind = $mainMod, 3, workspace, 3
		bind = $mainMod, 4, workspace, 4
		bind = $mainMod, 5, workspace, 5
		bind = $mainMod, 6, workspace, 6
		bind = $mainMod, 7, workspace, 7
		bind = $mainMod, 8, workspace, 8
		bind = $mainMod, 9, workspace, 9
		bind = $mainMod, 0, workspace, 10

		# Move active window to a workspace with mainMod + SHIFT + [0-9]
		bind = $mainMod SHIFT, 1, movetoworkspace, 1
		bind = $mainMod SHIFT, 2, movetoworkspace, 2
		bind = $mainMod SHIFT, 3, movetoworkspace, 3
		bind = $mainMod SHIFT, 4, movetoworkspace, 4
		bind = $mainMod SHIFT, 5, movetoworkspace, 5
		bind = $mainMod SHIFT, 6, movetoworkspace, 6
		bind = $mainMod SHIFT, 7, movetoworkspace, 7
		bind = $mainMod SHIFT, 8, movetoworkspace, 8
		bind = $mainMod SHIFT, 9, movetoworkspace, 9
		bind = $mainMod SHIFT, 0, movetoworkspace, 10

		# Example special workspace (scratchpad)
		bind = $mainMod, T, togglespecialworkspace, magic
		bind = $mainMod SHIFT, T, movetoworkspace, special:magic

		# Scroll through existing workspaces with mainMod + scroll
		bind = $mainMod, mouse_down, workspace, e+1
		bind = $mainMod, mouse_up, workspace, e-1

		# Move/resize windows with mainMod + LMB/RMB and dragging
		bindm = $mainMod, mouse:272, movewindow
		bindm = $mainMod, mouse:273, resizewindow
        binde = $mainMod SHIFT, h, resizeactive, 20 0
        binde = $mainMod SHIFT, l, resizeactive, -20 0
        binde = $mainMod SHIFT, k, resizeactive, 0 -20
        binde = $mainMod SHIFT, j, resizeactive, 0 20

		#----------Custom Workspaces---------------------#
		#Workspace 1 - Terminal/Work
        workspace = 1, on-created-empty:[float] $terminal
		windowrulev2 = float,noinitialfocus,workspace:1

		#Workspace 2 - Web Browser
        workspace = 2, on-created-empty:[pseudo] $browser

		#Workspace 3 - Notes
        workspace = 3, on-created-empty:[pseudo] $notebook

		#Workspace 4 - Calendar/Email
        workspace = 4, on-created-empty:[pseudo]

		#Workspace 5 - Drawing Tool
        workspace = 5, on-created-empty:[pseudo]

		#Workspace 6 - Media
        workspace = 6, on-created-empty:[pseudo] spotify

		#Workspace 7 - Misc
        workspace = 7, on-created-empty:[pseudo]

		#TEMPORARY RULES
		windowrule = move 2400 500, title:^(Laputa)(.*)$

		windowrule = move 800 0, title:^(Bedroom)(.*)$
			'';
		};
	};

	options = {
		hyprlandGeneral = mkOption {
			type = types.submodule {
				options = {
					gaps_in = mkOption{
						type = types.int;
						default = 1;
						example = 4;
					};
					gaps_out = mkOption{
						type = types.int;
						default = 1;
						example = 5;
					};
					border_size = mkOption{
						type = types.int;
						default = 1;
						example = 3;
					};
					layout = mkOption{
						type = types.str;
						example = "master";
					};
					allow_tearing = mkOption{
						type = types.bool;
						default = false;
					};
					"col.active_border" = mkOption{
						type = types.str;
						default = "rgba(cccccccc)";
					};
					"col.inactive_border" = mkOption{
						type = types.str;
						default = "rgba(64605000)";
					};
				};
				};
		};

		hyprlandWallpaper = lib.mkOption{
			default = ../wallpapers/sainte.jpg;
			type = lib.types.path;
			description = ''
				Wallpaper path for hyprland.
			'';
		};

		hyprlandMonitors = lib.mkOption{
			default = "DP-2, highrr, 0x0, 1";
			type = lib.types.str;
			description = ''
				Monitor rules for hyprland.
			'';
		};

	};



}
