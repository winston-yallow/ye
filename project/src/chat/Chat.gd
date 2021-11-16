extends MarginContainer


const Scroller := preload("res://src/messages/Scroller.gd")
const UserInput := preload("res://src/user_input/UserInput.gd")

const NPCs := {
	"Gobot": Color("#478cbf"),
	"Xan": Color("#7e7cee")
}
const YEs := [
	"ye", "ye", "ye", "ye", "ye", "ye", "ye",
	"Ye", "Ye", "Ye", "Ye",
	"yee",
	"yeee",
	"yeeee", "yeeee",
	"YE"
]

export var username: String = "Winston"
export var usercolor := Color("#ec2d74")

var _next_milestone := 4.0
var _fx_cooldown := false
var _score := 0

onready var _scroller: Scroller = $Main/VBox/Scroller
onready var _user_input: UserInput = $Main/VBox/UserInput
onready var _score_label: Label = $Main/InfoPanel/Score
onready var _timer: Timer = $Timer
onready var _fx_small: Particles2D = $Main/InfoPanel/FxSmall
onready var _fx_big: Particles2D = $Main/InfoPanel/FxBig


func _ready() -> void:
	randomize()
	# warning-ignore:return_value_discarded
	_user_input.connect("message_entered", self, "_on_message_entered")
	# warning-ignore:return_value_discarded
	_timer.connect("timeout", self, "_on_timeout")


func _on_message_entered(content: String) -> void:
	_scroller.add_message(username, content, usercolor)
	
	var correctness := 0
	var last := "y"
	for letter in content.to_lower():
		if last in "ye" and letter in "ye.!?":
			correctness += 1
		elif not letter in " ":
			correctness -= 1
		last = letter
	if correctness > 1:
		_add_score(min(correctness, 5))
	
	yield(get_tree().create_timer(rand_range(0.1, 0.5)), "timeout")
	_send_npc_message()


func _add_score(amount: int) -> void:
	_score += amount
	_score_label.text = str(_score)
	if not _fx_cooldown:
		_fx_cooldown = true
		_fx_small.emitting = true
		yield(get_tree().create_timer(1.0), "timeout")
		_fx_cooldown = false
	if _score >= _next_milestone:
		_next_milestone *= 2.0
		_fx_big.emitting = true


func _send_npc_message() -> void:
	var npc_name: String = NPCs.keys()[randi() % NPCs.size()]
	var npc_color: Color = NPCs[npc_name]
	var npc_ye: String = YEs[randi() % YEs.size()]
	_scroller.add_message(npc_name, npc_ye, npc_color)


func _on_timeout():
	_send_npc_message()
	_timer.wait_time = rand_range(0.8, 8.0)
