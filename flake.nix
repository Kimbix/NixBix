{
	description = "Nixos config flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		ags.url = "github:Aylur/ags";

		hyprland = {
			type = "git";
			url = "https://github.com/hyprwm/Hyprland";
			submodules = true;
			rev = "4cdddcfe466cb21db81af0ac39e51cc15f574da9";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

	};

	outputs = { self, nixpkgs, ... }@inputs: {
		nixosConfigurations.default = nixpkgs.lib.nixosSystem {
			specialArgs = {inherit inputs;};
			modules = [
				./hosts/default/configuration.nix
				inputs.home-manager.nixosModules.default
			];
		};
	};
}
