extends CharacterBody2D

@export var speed : int = 250

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()
	
func get_input() -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	


func _on_shield_area_entered(area: Area2D) -> void:
	if area.has_method("bounce_back"):
		var new_direction = (get_global_mouse_position() - global_position).normalized()
		area.call("bounce_back", new_direction)
		$OdrazeniSurikenu.play()
	
func _ready() -> void:
	add_to_group("player")
	


func _on_shield_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.has_method("bounce_from_shield"):
		body.call("bounce_from_shield", global_position)
