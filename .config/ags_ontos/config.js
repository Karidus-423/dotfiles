import { Bar } from "./widgets/bar/bar.js"
import { applauncher } from "./widgets/applauncher/launcher.js"

App.config({
	style: "./style.css",
	windows: [
		Bar,
		applauncher,
	]
})

