{ ... }: {
	programs.oh-my-posh = {
		enable = true;
	};

	home.file.".config/oh-my-posh/config.toml".source = ./config.toml;
}
