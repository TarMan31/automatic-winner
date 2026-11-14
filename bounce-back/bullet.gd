extends Area2D

@export var speed: float = 400.0

var direction: Vector2 = Vector2.RIGHT


func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta


func aim_at(target_position: Vector2) -> void:
	direction = global_position.direction_to(target_position)
