{ lib, pkgs, ... }: 
let
	mkRule = import ../window-managers/app-configuration-generator.nix { inherit lib; };
in 
	mkRule {
		appPackage = pkgs.vesktop;
		name = "Vesktop";
		cmd = "vesktop";

		autostartEnable = true;
		autostartWorkspaceEnable = true;
		autostartWorkspaceSpecial = true;
		autostartWorkspaceName = "discord";

		workspaceEnable = true;
		workspaceSpecial = true;
		workspaceKeybindEnable = true;
		workspaceOnCreatedEmptyOpen = true;

		workspaceName = "discord";
		workspaceKeybindKey = "d";
		workspaceKeybindSuper = true;

		appClass = "discord";
		appTitle = "Discord";
	}
