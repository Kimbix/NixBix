{ lib, pkgs, ... }: 
let
	mkRule = import ../window-managers/app-configuration-generator.nix { inherit lib; };
in 
	mkRule {
		appPackage = pkgs.obsidian;
		name = "Obsidian";
		cmd = "obsidian";

		autostartEnable = true;
		autostartWorkspaceEnable = true;
		autostartWorkspaceSpecial = true;
		autostartWorkspaceName = "obsidian";

		workspaceEnable = true;
		workspaceSpecial = true;
		workspaceKeybindEnable = true;
		workspaceOnCreatedEmptyOpen = true;

		workspaceName = "obsidian";
		workspaceKeybindKey = "n";
		workspaceKeybindSuper = true;

		appClass = "obsidian";
		appTitle = "Obsidian";
	}
