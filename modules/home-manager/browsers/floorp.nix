{ lib, pkgs, ... }: 
let
	mkRule = import ../window-managers/app-configuration-generator.nix { inherit lib; };
in 
	mkRule {
		appPackage = pkgs.floorp;
		name = "Floorp";
		cmd = "floorp";

		autostartEnable = true;
		autostartWorkspaceEnable = true;
		autostartWorkspaceId = "1";

		workspaceEnable = true;
		workspaceKeybindEnable = true;
		workspaceOnCreatedEmptyOpen = true;

		workspaceId = "1";
		workspaceKeybindKey = "b";
		workspaceKeybindSuper = true;

		appClass = "floorp";
		appTitle = "Ablaze Floorp";
	}
