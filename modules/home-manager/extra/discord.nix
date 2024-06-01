{ config, lib, pkgs, ... }: {
	options = {
		discord.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Enable discord for chatting with the boys";
		};

		discord.autostart.enable = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "Autostart discord";
		};

		discord.autostart.workspace.name = lib.mkOption {
			type = lib.types.str;
			default = "";
			description = "Workspace where discord should be autostarted";
		};

		discord.autostart.workspace.special = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "If the workspace where we're instantiating it is a special workspace (Scratchpads)";
		};

		discord.workspace.name = lib.mkOption {
			type = lib.types.str;
			default = "";
			description = "Which workspace to automatically move discord";
		};

		discord.workspace.special = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "If the workspace where discord will be is a special workspace";
		};

		discord.workspace.open-if-empty = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "If the workspace is empty, open discord";
		};

		discord.workspace.keybind.key = lib.mkOption {
			type = lib.types.str;
			default = "";
			description = "Key for opening the discord workspace";
		};

		discord.workspace.keybind.super = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "If the keybind requieres super to be pressed";
		};

		discord.workspace.keybind.shift = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "If the keybind requieres shift to be pressed";
		};

		discord.workspace.keybind.control = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "If the keybind requieres control to be pressed";
		};

		discord.workspace.keybind.alt = lib.mkOption {
			type = lib.types.bool;
			default = false;
			description = "If the keybind requieres alt to be pressed";
		};
	};

	config = let
		discordEnable = config.discord.enable;
		discordAutostart = discordEnable && config.discord.enable;

		autostartWorkspaceName = config.discord.autostart.workspace.name;
		autostartWorkspaceSpecial = config.discord.autostart.workspace.special;
		workspaceName = config.discord.workspace.name;
		workspaceSpecial = config.discord.workspace.special;

		discordPackage = (if discordEnable then [ pkgs.discord ] else []);
		discordHyprAutostart = 
			(if discordEnable && discordAutostart then
				"[workspace " +
				(if autostartWorkspaceSpecial then
					"special:"
				else
					""
				) +
				autostartWorkspaceName +
				" silent] discord"
			else
				""
			);

		discordHyprWindowrule =
			(if discordEnable then
				"workspace " +
				(if workspaceSpecial then
					"special:"
				else
					""
				) +
				workspaceName +
				",class:^(.*discord.*)$,title:^(.*discord.*)$"
			else
				""
			);

		discordKey = config.discord.workspace.keybind.key;
		discordSuper = config.discord.workspace.keybind.super;
		discordShift = config.discord.workspace.keybind.shift;
		discordControl = config.discord.workspace.keybind.control;
		discordAlt = config.discord.workspace.keybind.alt;

		discordWorkspaceKeybind =
			(if discordEnable && discordKey != "" then
				(if discordSuper then "SUPER " else "") +
				(if discordShift then "SHIFT " else "") +
				(if discordControl then "CONTROL " else "") +
				(if discordAlt then "ALT " else "") +
				", " +
				discordKey + ", " +
				(if workspaceSpecial then
					"togglespecialworkspace, "
				else
					"focusworkspaceoncurrentmonitor, "
				) +
				workspaceName
				else
				""
			);

		onCreatedEmpty = config.discord.workspace.open-if-empty;
		workspaceRule =
			(if discordEnable then
				(if workspaceSpecial then "special:" else "name:") +
				(if workspaceName != "" then workspaceName + ", " else "") +
				(if onCreatedEmpty then "on-created-empty:discord" else "")
			else
				""
			);
	in {
		home.packages = discordPackage;
		wayland.windowManager.hyprland.settings = {
			exec-once = [ discordHyprAutostart ];
			windowrulev2 = [ discordHyprWindowrule ];
			bind = [ discordWorkspaceKeybind ];
			workspace = [ workspaceRule ];
		};
	};
}
