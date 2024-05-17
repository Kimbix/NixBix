const audio = await Service.import("audio");

import { hyprland } from "resource:///com/github/Aylur/ags/service/hyprland.js";
import { Workspace } from "types/service/hyprland";

const hyprland_workspace_button = (workspace: Workspace) => Widget.Button({
	on_clicked: () => hyprland.messageAsync(`dispatch workspace ${workspace.id}`),
	setup: self => {
		if (hyprland.active.workspace.id == workspace.id) { self.label = ""; return; }
		if (hyprland.workspaces.some(ws => ws.id == workspace.id)) { self.label = ""; return; }
		self.label = ""; return;
	}
});

const hyprland_workspaces_box = () => Widget.Box({
	children: hyprland.workspaces.map((workspace) => hyprland_workspace_button(workspace))
});

const hyprland_workspaces_eventbox = () => Widget.EventBox({
	class_name: "hyprland-workspaces-container",
	on_scroll_up: () => hyprland.messageAsync("dispatch workspace +1"),
	on_scroll_down: () => hyprland.messageAsync("dispatch workspace -1"),
	child: hyprland_workspaces_box()
});

const date_string = Variable("date", { poll: [1000, "date +'%-d/%-m'"] });
const date_label = () => Widget.Label({ label: date_string.bind() });

const time_string = Variable("time", { poll: [1000, "date +'%_I:%M'"] });
const time_label = () => Widget.Label({ label: time_string.bind() });

const date_time_box = () => Widget.Box({
	vertical: true,
	children: [ date_label(), time_label() ]
});

const playback_volume_label = () => Widget.Label({
	setup: self => self.hook(audio.speaker, () => self.label = Math.round(audio.speaker.volume * 100).toString() + "%")
});
const playback_volume_eventbox = () => Widget.EventBox({
	child: playback_volume_label(),
	on_scroll_up: () => audio.speaker.volume += 0.05,
	on_scroll_down: () => audio.speaker.volume -= 0.05,
});

const recording_volume_label = () => Widget.Label({
	setup: self => self.hook(audio.microphone, () => self.label = Math.round(audio.microphone.volume * 100).toString() + "%")
});
const recording_volume_eventbox = () => Widget.EventBox({
	child: recording_volume_label(),
	on_scroll_up: () => audio.microphone.volume += 0.05,
	on_scroll_down: () => audio.microphone.volume -= 0.05,
});

const audio_box = () => Widget.Box({
	vertical: true,
	children: [
		playback_volume_eventbox(),
		recording_volume_eventbox()
	]
});

const separator = () => Widget.Label({
	label: "|",
});

const Bar = (monitor: number) => Widget.Window({
	exclusivity: "exclusive",
	anchor: ["top", "left", "right"],
	name: `bar-${monitor}`,
	child: Widget.CenterBox({
		spacing: 8,
		vertical: false,
		start_widget: Widget.Box({ hpack: "start", children: [ hyprland_workspaces_eventbox() ]}),
		// center_widget: null,
		end_widget: Widget.Box({ hpack: "end", children: [ date_time_box(), separator(), audio_box() ] }),
	}),


});

const css = "/tmp/ags/css"
App.config({
	style: css,
	windows: [
		Bar(0)
	]
});
