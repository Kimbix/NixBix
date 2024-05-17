{ pkgs, ... }: {
	home.packages = [
		pkgs.grimblast
	];
	
	wayland.windowManager.hyprland.settings.bind = [
		## Screenshots
		# Print -> Print Screen
		# Control -> Save Result
		# Shift -> Area
		# Alt -> Application
		''SUPER, Print, exec, grimblast copy screen''
		''SUPER SHIFT, Print, exec, grimblast copy area''
		''SUPER ALT, Print, exec, grimblast copy active''

		''SUPER CONTROL, Print, exec, grimblast copysave screen''
		''SUPER CONTROL SHIFT, Print, exec, grimblast copysave area''
		''SUPER CONTROL ALT, Print, exec, grimblast copysave active''
	];
}
