{ pkgs, lib, config, inputs, ... }: {

	options = {
		hyprland.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable hyprland as a window manager";
		};

		hyprland.utilities.hyprpaper.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable hyprpaper as a wallpaper utility";
		};

		hyprland.utilities.hyprpaper.autostart = lib.mkOption {
			type = lib.types.bool;
			default = true;
			description = "Weather to autostart hyprpaper";
		};

		hyprland.utilities.hyprpaper.wallpaper = lib.mkOption {
			type = lib.types.path;
			default = null;
			description = "Source for the wallpaper";
		};

		hyprland.utilities.hyprpicker.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable hyprpicker color picking utility";
		};

		hyprland.utilities.hyprcursor.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable cursor setting utility";
		};
	};

	config = let
		hyprpaperEnabled = config.hyprland.utilities.hyprpaper.enable;
		hyprpickerEnabled = config.hyprland.utilities.hyprpicker.enable;
		hyprcursorEnabled = config.hyprland.utilities.hyprcursor.enable;
		hyprpaperAutostart = config.hyprland.utilities.hyprpaper.autostart;

		hyprpaperWallpaperPath = ".config/hypr/wallpaper.png";
		hyprpaperWallpaperSource = config.hyprland.utilities.hyprpaper.wallpaper;
		hyprpaperConfig = if hyprpaperEnabled then ''
preload = ${hyprpaperWallpaperPath}
wallpaper = DP-1,${hyprpaperWallpaperPath}
wallpaper = DP-3,${hyprpaperWallpaperPath}
		'' else null;

		hyprUtils = 
			(if hyprpaperEnabled then [ pkgs.hyprpaper ] else []) ++
			(if hyprpickerEnabled then [ pkgs.hyprpicker ] else []) ++
			(if hyprcursorEnabled then [ pkgs.hyprcursor ] else []);
		hyprAutostart = 
			(if hyprpaperAutostart then [ "hyprpaper" ] else []);
	in {

		# Actual Config
		home.packages = hyprUtils;

		# Hyprpaper stuff
		home.file.${hyprpaperWallpaperPath}.source = hyprpaperWallpaperSource;
		home.file.".config/hypr/hyprpaper.conf".text = hyprpaperConfig;

		wayland.windowManager.hyprland = {
			enable = config.hyprland.enable;
			package = inputs.hyprland.packages.${pkgs.system}.hyprland;
			settings = {
				general = {
					gaps_in = 0;
					gaps_out = 0;
				};
				env = [
					''XCURSOR_THEME,macOS-BigSur-White''
					''XCURSOR_SIZE,32''
					''HYPRCURSOR_THEME,macOS-BigSur-White''
					''HYPRCURSOR_SIZE,32''
					''_JAVA_AWT_WM_NONREPARENTING,1''
				];

				exec-once = hyprAutostart ++ [
					''foot -s''
				];

				windowrulev2 = [
# -- Fix odd behaviors in IntelliJ IDEs --
#! Fix focus issues when dialogs are opened or closed
''windowdance,,class:^(jetbrains-.*)$,floating:1''
#!een showing in weird places and prevent annoying focus takeovers
''center,class:^(jetbrains-.*)$,title:^(splash)$,floating:1''
''nofocus,class:^(jetbrains-.*)$,title:^(splash)$,floating:1''
''noborder,class:^(jetbrains-.*)$,title:^(splash)$,floating:1''
#!find windows
''center,class:^(jetbrains-.*)$,title:^( )$,floating:1''
''stayfocused,class:^(jetbrains-.*)$,title:^( )$,floating:1''
''noborder,class:^(jetbrains-.*)$,title:^( )$,floating:1''
#! flicker when autocomplete or tooltips appear
''nofocus,class:^(jetbrains-.*)$,title:^(win.*)$,floating:1''
				];

				bind = [
					## Hyprpicker
					# Pick Color -> Super + p
					''SUPER, p, exec, hyprpicker -a  -f hex''
					# Pick Color -> Super + P
					''SUPER SHIFT, p, exec, hyprpicker -a  -f rgb''

					## Focus Change
					# Focus Up -> Super + k
					''SUPER, k, movefocus, u''
					# Focus Right -> Super + l
					''SUPER, l, movefocus, r''
					# Focus Down -> Super + j
					''SUPER, j, movefocus, d''
					# Focus Left -> Super + h
					''SUPER, h, movefocus, l''

					## Window Resize 
					# Resize Up -> Super + k
					''SUPER SHIFT , k, resizeactive, 0 -25''
					# Resize Right -> Super + l
					''SUPER SHIFT, l, resizeactive, 25 0''
					# Resize Down -> Super + j
					''SUPER SHIFT, j, resizeactive, 0 25''
					# Resize Left -> Super + h
					''SUPER SHIFT, h, resizeactive, -25 0''

					## Change Workspace
					# Change to Workspace N -> Super + n
					''SUPER, 1, focusworkspaceoncurrentmonitor, 1''
					''SUPER, 2, focusworkspaceoncurrentmonitor, 2''
					''SUPER, 3, focusworkspaceoncurrentmonitor, 3''
					''SUPER, 4, focusworkspaceoncurrentmonitor, 4''
					''SUPER, 5, focusworkspaceoncurrentmonitor, 5''
					''SUPER, 6, focusworkspaceoncurrentmonitor, 6''
					''SUPER, 7, focusworkspaceoncurrentmonitor, 7''
					''SUPER, 8, focusworkspaceoncurrentmonitor, 8''
					''SUPER, 9, focusworkspaceoncurrentmonitor, 9''
					''SUPER, 0, focusworkspaceoncurrentmonitor, 10''

					## Move to Workspace
					# Move to Workspace N -> Super + n
					''SUPER SHIFT, 1, movetoworkspace, 1''
					''SUPER SHIFT, 2, movetoworkspace, 2''
					''SUPER SHIFT, 3, movetoworkspace, 3''
					''SUPER SHIFT, 4, movetoworkspace, 4''
					''SUPER SHIFT, 5, movetoworkspace, 5''
					''SUPER SHIFT, 6, movetoworkspace, 6''
					''SUPER SHIFT, 7, movetoworkspace, 7''
					''SUPER SHIFT, 8, movetoworkspace, 8''
					''SUPER SHIFT, 9, movetoworkspace, 9''
					''SUPER SHIFT, 0, movetoworkspace, 10''

					## Exit
					# Exit Hyprland -> Super + Control + Q
					''SUPER CONTROL, Q, exit''

					## Window Manipulation
					# Kill Screen -> Super + W
					''SUPER, W, killactive''
					# Fullscreen Toggle -> Super + F
					''SUPER, F, fullscreen''
					# Floating Toggle -> Super + Control + F
					''SUPER CONTROL, F, togglefloating''

					## Groups
					# Toggles Groups -> Super + ;
					''SUPER, code:47, togglegroup''
					# Toggles Group Lock -> Super + Control + ;
					''SUPER CONTROL, code:47, lockactivegroup, toggle''
					# Forwards in Group -> Super + Control + k
					''SUPER CONTROL, k, changegroupactive, f''
					# Backwards in Group -> Super + Control + k
					''SUPER CONTROL, k, changegroupactive, b''
					# Remove from Group -> Super + Control + k
					''SUPER CONTROL, l, moveoutofgroup, r''

					## Run Applications
					# Terminal -> Super + Return
					''SUPER, Return, exec, footclient''
					# Desktop Apps -> Super + Space
					''SUPER, Space, exec, rofi -show drun''
					# Command -> Super + Shift + Space
					''SUPER SHIFT, Space, exec, rofi -show run''

					## Special Workspaces
					# Streaming Workspace -> Super + S
					# NO AUTO-OPEN
					''SUPER, S, togglespecialworkspace, stream''
					''SUPER SHIFT, S, movetoworkspace, special:stream''
					# Music Workspace -> Super + M
					# Auto-opens Music Player
					''SUPER, M, togglespecialworkspace, music''
					''SUPER, M, exec, pidof ncmpcpp || foot -a MusicTerminal pkgs.ncmpcpp''
					''SUPER SHIFT, M, movetoworkspace, special:music''
				];

				bindm = [
					"SUPER, mouse:272, movewindow"
					"SUPER, mouse:273, resizewindow"
				];
			};
			systemd.enable = false;
		};
	};
}
