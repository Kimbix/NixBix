{ ... }: {
	programs.foot = {
		enable = true;
		server.enable = true;

		settings = {
		  main = {
				term = "foot";

				font = "JetBrainsMono Nerd Font Mono:size=16";
				dpi-aware = "yes";
			};
			mouse = {
				hide-when-typing = "yes";
			};
		};
	};
}
