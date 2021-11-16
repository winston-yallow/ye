extends MarginContainer


export var highlight_style: StyleBox

onready var _panel: Panel = $Panel
onready var _picture: TextureRect = $HBox/ProfilePicture
onready var _username: Label = $HBox/VBox/Header/Name
onready var _time: Label = $HBox/VBox/Header/Time
onready var _content: Label = $HBox/VBox/Content


func _ready() -> void:
	# warning-ignore:return_value_discarded
	connect("mouse_entered", self, "_on_mouse_entered")
	# warning-ignore:return_value_discarded
	connect("mouse_exited", self, "_on_mouse_exited")


func set_details(user: String, content: String, color: Color) -> void:
	_username.text = user
	_username.add_color_override("font_color", color)
	_picture.modulate = color
	_content.text = content
	var time := OS.get_time()
	_time.text = "%02d:%02d" % [time.hour, time.minute]


func _on_mouse_entered() -> void:
	_panel.add_stylebox_override("panel", highlight_style)


func _on_mouse_exited() -> void:
	_panel.add_stylebox_override("panel", null)
