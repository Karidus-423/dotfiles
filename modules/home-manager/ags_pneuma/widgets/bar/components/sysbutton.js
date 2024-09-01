const network = await Service.import("network")
const bluetooth = await Service.import("bluetooth")

const WifiIndicator = () => Widget.EventBox({
	name: "Wifi Box",
	child: Widget.Icon({
		name: "Wifi Icon",
		icon: network.wifi.bind('icon_name'),
	}),
	on_hover: () => Widget.Label({
		name: "Wifi Name",
		label: network.wifi.bind('ssid')
			.as(ssid => ssid || 'Unknown'),
	}),
})

const WiredIndicator = () => Widget.Icon({
	name: "Ethernet Icon",
	icon: network.wired.bind('icon_name'),
})

const wifi = () => Widget.Stack({
	name: "Network box",
	children: {
		wifi: WifiIndicator(),
		wired: WiredIndicator(),
	},
	shown: network.bind('primary').as(p => p || 'wifi'),
})


const bluetoothIndicator = () => Widget.Icon({
	name: "Bluetooth Box",
	icon: bluetooth.bind('enabled').as(on =>
		`bluetooth-${on ? 'active' : 'disabled'}-symbolic`),
})

const sysbutton = Widget.EventBox({
	name: "Sys EventBox",
	class_name: "SysButton",
	child: Widget.Box({
		name: "Sys InnerBox",
		spacing: 5,
		vertical: false,
		children: [wifi(), bluetoothIndicator()],
	})
})

export { sysbutton }
