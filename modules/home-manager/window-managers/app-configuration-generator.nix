{
	lib,
}:
{
	appPackage,
	name ? null,
	cmd ? null,

	autostartEnable ? false,
	autostartWorkspaceEnable ? false,
	autostartWorkspaceId ? null,
	autostartWorkspaceName ? null,
	autostartWorkspaceSpecial ? false,

	workspaceEnable ? false,
	workspaceOnCreatedEmptyOpen ? false,

	workspaceId ? null,
	workspaceName ? null,
	workspaceSpecial ? false,
	workspaceKeybindEnable ? false,

	workspaceKeybindKey ? "",
	workspaceKeybindSuper ? false,
	workspaceKeybindShift ? false,
	workspaceKeybindControl ? false,
	workspaceKeybindAlt ? false,

	appClass ? null,
	appTitle ? null,
	...
}:
let
	# Here we generate hyprlands autostart
	hyprEndAutostartType =
	if autostartWorkspaceSpecial
		then "special:"
	else if autostartWorkspaceName != null
		then "name:"
		else "";
	hyprEndAutostartWorkspace =
	if autostartWorkspaceName != null
		then autostartWorkspaceName
	else if autostartWorkspaceId != null && !autostartWorkspaceSpecial
		then autostartWorkspaceId
		else "";
	hyprAutostartCmd = "hyprctl dispatch workspace ${hyprEndAutostartType}${hyprEndAutostartWorkspace} && ${cmd} &";
	
	hyprEndType =
	if workspaceSpecial
		then "special:"
	else if workspaceName != null
		then "name:"
		else "";
	hyprEndWorkspaceName =
	if workspaceName != null
		then workspaceName
	else if workspaceId != null && !workspaceSpecial
		then workspaceId
		else "";
	hyprWindowRule = "workspace ${hyprEndType}${hyprEndWorkspaceName},class:^(.*${appClass}.*)$,title:^(.*${appTitle}.*)$";

	hyprWorkspaceBindMods =
		(if workspaceKeybindSuper   then "SUPER"   else "") +
		(if workspaceKeybindShift   then " SHIFT"   else "") +
		(if workspaceKeybindControl then " CONTROL" else "") +
		(if workspaceKeybindAlt     then " ALT"     else "");
	hyprWorkspaceBindType =
	if workspaceSpecial
		then "togglespecialworkspace"
	else if workspaceName != null || workspaceId != null
		then "focusworkspaceoncurrentmonitor"
		else "";
	hyprWorkspaceBind = "${hyprWorkspaceBindMods},${workspaceKeybindKey},${hyprWorkspaceBindType},${hyprEndWorkspaceName}";

	hyprWorkspaceRuleEmpty =
	if workspaceOnCreatedEmptyOpen
		then "on-created-empty:${cmd}"
		else "";
	hyprWorkspaceRule = "${hyprEndType}${hyprEndWorkspaceName}, ${hyprWorkspaceRuleEmpty}";
in {
	home.packages = [ appPackage ];
	wayland.windowManager.hyprland.settings = {
		exec-once = lib.mkIf autostartEnable [ hyprAutostartCmd ];
		windowrulev2 = lib.mkIf workspaceEnable [ hyprWindowRule ];
		bind = lib.mkIf workspaceEnable [ hyprWorkspaceBind ];
		workspace = lib.mkIf workspaceEnable [ hyprWorkspaceRule ];
	};
}
