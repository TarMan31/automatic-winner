extends Area2D

@export var rychlost_strely: float = 400.0

var direction: Vector2 = Vector2.RIGHT
var odrazena_strela: bool = false

func _physics_process(delta: float) -> void:
	global_position += direction * rychlost_strely * delta
	if odrazena_strela:
		for kaktus in get_tree().get_nodes_in_group("enemy"):
			if global_position.distance_to(kaktus.global_position) < 40.0:
				kaktus.call("bum_zasah")
				queue_free()
				return


func aim_at(target_position: Vector2) -> void:
	direction = global_position.direction_to(target_position)
	
	
func bounce_back(new_direction: Vector2) -> void:
	direction = new_direction.normalized()
	odrazena_strela = true	
	
func _on_body_entered(body: Node2D) -> void:
	print("ZASAH: ", body.name, " | enemy: ", body.is_in_group("enemy"), " | odrazena: ", odrazena_strela)
	if body.is_in_group("player") and not odrazena_strela:
		body.take_damage(10)
		queue_free()

	elif body.is_in_group("enemy") and odrazena_strela:
		body.call("bum_zasah")
		queue_free()
