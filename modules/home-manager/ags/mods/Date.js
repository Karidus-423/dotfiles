import Widget from 'resource:///com/github/Aylur/ags/widget.js';
import GLib from 'gi://GLib';

/**
 * @param {import('types/widgets/label').Props & {
 *   format?: string,
 *   interval?: number,
 * }} o
 */
export default ({
	format = '%H:%M\n%B%e. %A',
	interval = 1000,
	class_name = "clock",
	...rest
} = {}) => Widget.Label({
	class_name: `clock ${class_name}`,
	...rest,
	setup: self => self.poll(interval, () => {
		self.label = GLib.DateTime.new_now_local().format(format) || 'wrong format';
	}),
});
