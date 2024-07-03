import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import App from 'resource:///com/github/Aylur/ags/app.js';
import Clock from "./mods/Clock.js"
import Status from "./mods/Status.js"
import Systray from "./mods/Systray.js"
import Workspaces from "./mods/Workspaces.js"
import Volume from "./mods/Volume.js"



const top = () => Widget.Box({
	spacing: 6,
	homogeneous: false,
	vertical: true,
	children: [Systray(), Clock()]
});

const middle = () => Widget.Box({
	spacing: 6,
	homogeneous: false,
	vertical: true,
	vpack: "end",
	children: [Workspaces()]
})
const bottom = () => Widget.Box({
	spacing: 6,
	homogeneous: false,
	vertical: true,
	vpack: "end",
	children: [Status(), Volume()]
});

const box = () => Widget.CenterBox({
	class_name: "bar",
	homogeneous: false,
	spacing: 8,
	vertical: true,
	start_widget: top(),
	center_widget: middle(),
	end_widget: bottom(),
})

const bar = Widget.Window({
	name: 'bar',
	anchor: ['top', 'left', 'bottom'],
	exclusivity: "exclusive",
	margins: [0, 0, 0, 0],
	child: box(),
})

export { bar }
