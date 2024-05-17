{ pkgs, ... }: {
	programs.zsh.enable = true;
	programs.starship = {
		enableZshIntegration = true;
	};

	programs.zsh.shellAliases = {
		nix-rebuild-default = "sudo nixos-rebuild switch --flake ~/.sources/nix/#default";
	};
}
