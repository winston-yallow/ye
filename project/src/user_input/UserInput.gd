extends PanelContainer


signal message_entered(content)

onready var _message_input: LineEdit = $MarginContainer/HBox/MessageInput
onready var _send_btn: Button = $MarginContainer/HBox/SendBtn


func _ready() -> void:
	# warning-ignore:return_value_discarded
	_send_btn.connect("pressed", self, "_on_send")
	# warning-ignore:return_value_discarded
	_message_input.connect("text_entered", self, "_on_text_entered")
	_message_input.grab_focus()


func _on_send() -> void:
	_on_text_entered(_message_input.text)


func _on_text_entered(content: String) -> void:
	_message_input.clear()
	if content.length() > 0:
		emit_signal("message_entered", content)
