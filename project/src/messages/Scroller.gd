extends ScrollContainer


const MessageScene := preload("res://src/messages/Message.tscn")
const Message := preload("res://src/messages/Message.gd")

onready var _messages: VBoxContainer = $MarginContainer/Messages


func add_message(user: String, content: String, color: Color) -> void:
	var msg: Message = MessageScene.instance()
	_messages.add_child(msg)
	msg.set_details(user, content, color)
	yield(get_tree(), "idle_frame")
	scroll_vertical = get_v_scrollbar().max_value
