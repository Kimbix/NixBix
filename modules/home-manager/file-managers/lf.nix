{ pkgs, config, ... }: {
	programs.lf = {

		enable = true;

		settings = {
			sixel = true;
			preview = true;
			drawbox = true;
			hidden = true;
			icons = true;
			ignorecase = true;
		};

		keybindings = {
			"<enter>" = "open";
		};

		commands = {
			open = ''$$OPENER $f'';
			dragon-out = ''%${pkgs.xdragon} -a -x "$fx"'';
			nv-open = ''$$EDITOR $f'';
			mkdir = ''
			''${{
				printf "Directory Name: "
				read DIR
				mkdir $DIR
			}}
			'';
		};
	};

	programs.lf = {
		previewer = {
			keybinding = "i";
			source = "${pkgs.ctpv}/bin/ctpv";
		};
		extraConfig = ''
			&${pkgs.ctpv}/bin/ctpv -s $id
			cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
			set cleaner ${pkgs.ctpv}/bin/ctpvclear
		'';
	};
	home.file.".config/ctpv/config".text = "set chafasixel";
}
