{...}:
	{
		home.file.".config/hypr/hyprland.conf".text = ''
		# Execute your favorite apps at launch
		exec-once = pipewire-pulse
		exec-once = ags
		exec-once = swww-daemon
		exec-once = swww img ~/dots/hosts/ontos/wallpapers/neighbor_street.webp --transition-type=grow
		exec-once = gammastep

		# Source a file (multi-file configs)
		# source = ~/.config/hypr/myColors.conf

		# Set programs that you use
		$terminal = alacritty
		$fileManager = ranger
		$menu = wofi --show drun --term alacritty -n
		$browser = firefox
		$note = obsidian

		# Some default env vars.
        env = GDK_SCALE,2
		env = XCURSOR_SIZE,24
		env = QT_QPA_PLATFORMTHEME,qt5ct # change to qt6ct if you have that
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

		general {
		    # See https://wiki.hyprland.org/Configuring/Variables/ for more

		    gaps_in = 4
		    gaps_out = 20
		    border_size = 5
		    col.active_border = rgba(b2d498ee) rgba(b3dcdda8) 0deg
		    col.inactive_border = rgba(acafadee) rgba(110f0fa5) 90deg

		    layout = dwindle

		    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
		    allow_tearing = false
		}

		decoration {
		    # See https://wiki.hyprland.org/Configuring/Variables/ for more

		    rounding = 5
		    
		    blur {
			enabled = false
		    }

		    drop_shadow = false
		    shadow_range = 4
		    shadow_render_power = 3
		    col.shadow = rgba(1a1a1aee)
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
		    animation = workspaces, 1, 3, foosh, slide
		}

		dwindle {
		    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
		    pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
		    preserve_split = true # you probably want this
            force_split = 2
		}

		master {
		    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
		    new_is_master = false
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
        windowrule = pseudo, ^(alacritty)$


		# See https://wiki.hyprland.org/Configuring/Keywords/ for more
		$mainMod = SUPER

		# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
		bind = $mainMod, RETURN, exec, $terminal
		bind = $mainMod, Q, killactive, 
		bind = $mainMod_SHIFT, Q, exit, 
		bind = $mainMod, S, exec, $menu
		bind = $mainMod, E, exec, alacritty -e $filemanager
		bind = $mainMod, F, exec, $browser
		bind = $mainMod, V, togglefloating, 
		bind = $mainMod, P, pseudo, # dwindle
		bind = $mainMod, D, togglesplit, # dwindle
        bind = , Print,exec,grim -g "$(slurp -w 0)" - | swappy -f -


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
		bind = $mainMod SHIFT, S, movetoworkspace, special:magic

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
        workspace = 1, on-created-empty:[pseudo] $terminal

		#Workspace 2 - Web Browser
        workspace = 2, on-created-empty:[pseudo] $browser

		#Workspace 3 - Directory/Manuals
        workspace = 3, on-created-empty:[pseudo] $note

		#Workspace 4 - Calendar/Email

        workspace = 2, on-created-empty:[pseudo]

		#Workspace 5 - Drawing Tool

        workspace = 2, on-created-empty:[pseudo]

		#Workspace 6 - Media
        workspace = 6, on-created-empty:[pseudo] spotify

		#Monitors
        monitor=DP-3,highres,0x0,1
        monitor=DP-2,highres,0x0,1
        monitor=DP-4,highres,0x0,1
        monitor=DP-1,highres,0x0,1
		'';
}
