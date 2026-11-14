extends CharacterBody2D

@export var speed : int = 250

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
	
func get_input() -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	


func _on_shield_area_entered(area: Area2D) -> void:
	print("STRELA ZASAHLA STIT: ", area.name)
func _ready() -> void:
	add_to_group("player")
	
