{ config, lib, ... }: {
	options = {
		widgets.ags.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable ags for widgets";
		};
		widgets.ags.autostart = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Launch ags widgets on startup";
		};
	};
	config = let 
		agsEnable = config.widgets.ags.enable;
		agsAutostart = config.widgets.ags.autostart;

		agsAutostartHyprland = if agsEnable && agsAutostart && config.hyprland.utilities.hyprpaper.enable then true else false;
	in {
		programs.ags.enable = if agsEnable then true else false;
	  # home.file.".config/ags/".source = ../../../themes/void-purple/ags;
		wayland.windowManager.hyprland.settings.exec-once = if agsAutostartHyprland then [ "ags" ] else [];
	};
}
