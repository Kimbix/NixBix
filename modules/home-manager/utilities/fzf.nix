{ ... }: {
	programs.fzf = {
		enable = true;
		colors = {
			bg = "#161616";
			selected-bg = "#393939";
			preview-bg = "#131313";
			fg = "#D0D0D0";
			selected-fg = "#EE5396";
			preview-fg = "#EE5396";
		};
	};

	programs.fd = {
		enable = true;
	};
}
