const hyprland = await Service.import("hyprland")
const audio = await Service.import("audio")
const battery = await Service.import("battery")

const date = Variable("", {
	poll: [1000, 'date "+%H:%M\n%b %e."'],
})

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it

function Workspaces() {
	const activeId = hyprland.active.workspace.bind("id")
	const workspaces = hyprland.bind("workspaces")
		.as(ws => ws.map(({ id }) => Widget.Button({
			on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
			child: Widget.Label(`${id}`),
			class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
		})))

	return Widget.Box({
		class_name: "workspaces",
		children: workspaces,
		vertical: true,
	})
}




function Clock() {
	return Widget.Label({
		class_name: "clock",
		label: date.bind(),
	})
}


function Volume() {
	const icons = {
		101: "overamplified",
		67: "high",
		34: "medium",
		1: "low",
		0: "muted",
	}

	function getIcon() {
		const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
			threshold => threshold <= audio.speaker.volume * 100)

		return `audio-volume-${icons[icon]}-symbolic`
	}

	const icon = Widget.Icon({
		icon: Utils.watch(getIcon(), audio.speaker, getIcon),
	})

	const slider = Widget.Slider({
		hexpand: true,
		draw_value: false,
		on_change: ({ value }) => audio.speaker.volume = value,
		setup: self => self.hook(audio.speaker, () => {
			self.value = audio.speaker.volume || 0
		}),
		orientation: 1,
	})

	return Widget.Box({
		class_name: "volume",
		css: "min-width: 180px",
		children: [icon, slider],
		vertical: true,
	})
}


function BatteryLabel() {
	const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
	const icon = battery.bind("percent").as(p =>
		`battery-level-${Math.floor(p / 10) * 10}-symbolic`)

	return Widget.Box({
		class_name: "battery",
		visible: battery.bind("available"),
		children: [
			Widget.Icon({ icon }),
			Widget.LevelBar({
				widthRequest: 14,
				vpack: "center",
				value,
				orientation: 1,
			}),
		],
	})
}



// layout of the bar
function Top() {
	return Widget.Box({
		spacing: 8,
		children: [
			Clock(),
		],
	})
}

function Middle() {
	return Widget.Box({
		spacing: 8,
		children: [
			Workspaces(),
		],
	})
}

function Bottom() {
	return Widget.Box({
		hpack: "end",
		spacing: 8,
		children: [
			Volume(),
			BatteryLabel(),
		],
	})
}

function Bar(monitor = 0) {
	return Widget.Window({
		name: `bar-${monitor}`, // name has to be unique
		class_name: "bar",
		monitor,
		anchor: ["left", "top", "bottom"],
		exclusivity: "exclusive",
		child: Widget.CenterBox({
			start_widget: Top(),
			center_widget: Middle(),
			end_widget: Bottom(),
		}),
	})
}

App.config({
	style: "./style.css",
	windows: [
		Bar(),
		// you can call it, for each monitor
		// Bar(0),
		// Bar(1)
	],
})

export { }
