{ lib, pkgs, config, ... }: {
	options = {
		hyprland.enable = lib.mkOption {
			type = lib.types.boolean;
			default = false;
		};
	};

	config = {

	};
}
