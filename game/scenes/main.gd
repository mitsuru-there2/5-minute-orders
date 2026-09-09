extends Control
## Development entry point; not a gameplay screen.


func _ready() -> void:
	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	for side in ["left", "top", "right", "bottom"]:
		margin.add_theme_constant_override("margin_" + side, 24)
	add_child(margin)
	var label := Label.new()
	label.text = (
		"5 MINUTE ORDERS\n\nThink. Order. Wait.\n\n"
		+ "Development foundation · 0.0.1\nGameplay prototype coming next."
	)
	label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.add_theme_font_size_override("font_size", 22)
	margin.add_child(label)
