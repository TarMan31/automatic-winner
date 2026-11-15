extends Area2D

var pressure := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if pressure or not body.is_in_group("player"):
		return
	pressure = true
	body.checkpos= global_position
