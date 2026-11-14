extends Area2D

@export var rychlost_strely: float = 400.0

var direction: Vector2 = Vector2.RIGHT


func _physics_process(delta: float) -> void:
	global_position += direction * rychlost_strely * delta


func aim_at(target_position: Vector2) -> void:
	direction = global_position.direction_to(target_position)
	
	
func bounce_back(new_direction: Vector2) -> void:
	direction = new_direction.normalized()
	
func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(50)
		queue_free()
