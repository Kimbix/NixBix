{ config, pkgs, lib, ... }: {
	options = {
		neovim.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable neovim editor";
		};

		neovim.setDefault = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Set neovim as default text editor";
		};

		neovim.plugins = {
			telescope = {
				enable = lib.mkOption {
					type = lib.types.bool;
					default = false;
					description = "File finder for neovim";
				};
			};
		};
	};
	config = let 
		toLua = str: "lua << EOF\n${str}\nEOF\n";
		toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
		enabled = config.neovim.enable;
	in {
		programs.neovim = {
			enable = enabled;

			viAlias = enabled;
			vimAlias = enabled;
			vimdiffAlias = enabled;

			extraLuaConfig = ''
				${toLuaFile ./nvim/init.lua}
			'';

			plugins = if enabled then 
			with pkgs.vimPlugins; [
				telescope-nvim {
					plugin = telescope-nvim;
					config = toLuaFile ./nvim/lua/plugins/telescope.lua;
				}
			]
			else
			[];
		};
	};
}
