{ ... }: {
	programs.foot = {
		enable = true;
		server.enable = true;

		settings = {
		  main = {
				term = "foot";

				font = "JetBrainsMono Nerd Font Mono:size=16";
				dpi-aware = "yes";
				pad = "16x16 center";
			};

			mouse = {
				hide-when-typing = "yes";
			};
			colors = {
				background = "161616";
			};
		};
	};
}
