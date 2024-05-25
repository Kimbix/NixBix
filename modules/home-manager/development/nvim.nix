{ lib, pkgs, ... }: {
	home.packages = with pkgs; [
		ripgrep
		lua-language-server
		nil
		nodePackages.typescript-language-server
		nodePackages.eslint
	];

	programs.neovim = {
		enable = true;
		vimAlias = true;

		coc.enable = false;
		plugins = with pkgs.vimPlugins; [
			nvim-treesitter.withAllGrammars
		];
	};

	home.file.".config/nvim/" = {
		source = ./NeoBix;
		recursive = true;
	};
}
