const audio = await Service.import('audio')

const toggle = Widget.Button({
	on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
	child: Widget.Icon().hook(audio.speaker, self => {
		const vol = audio.speaker.volume * 100;
		const icon = [
			[101, 'overamplified'],
			[67, 'high'],
			[34, 'medium'],
			[1, 'low'],
			[0, 'muted'],
		].find(([threshold]) => threshold <= vol)?.[1];

		self.icon = `audio-volume-${icon}-symbolic`;
		self.tooltip_text = `Volume ${Math.floor(vol)}%`;
	}),
})

const slider = Widget.Slider({
	hexpand: true,
	draw_value: false,
	on_change: ({ value }) => audio.speaker.volume = value,
	setup: self => self.hook(audio.speaker, () => {
		self.value = audio.speaker.volume || 0
	}),
})


export default () => Widget.Box({
	children: [toggle, slider],
	class_name: "volume-box",
	vertical: true,
})
