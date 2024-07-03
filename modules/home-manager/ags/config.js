import App from 'resource:///com/github/Aylur/ags/app.js'
import * as Utils from 'resource:///com/github/Aylur/ags/utils.js'

import { bar } from "./widgets/bar/Bar.js"

let loadCSS = () => {
	const scss = `${App.configDir}/style/_style.scss`
	const css = `${App.configDir}/finalcss/style.css`
	Utils.exec(`sassc ${scss} ${css}`)
	App.resetCss() // reset if need
	App.applyCss(`${App.configDir}/finalcss/style.css`)
}

loadCSS()

Utils.monitorFile(
	`${App.configDir}/style/`,
	function() {
		loadCSS()
	},
)

export default { windows: [bar], style: `${App.configDir}/finalcss/style.css` }
