{ pkgs, ... }: {
	
	programs.lf = {

		enable = true;

		settings = {
			preview = true;
			hidden = true;
			drawbox = true;
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
}
