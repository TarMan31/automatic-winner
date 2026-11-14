extends CharacterBody2D


@export var speed: float = 50
func _physics_process(delta: float) -> void:
	var player = get_tree(). get_first_node_in_group("player")
	
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		for i in get_slide_collision_count():
			var narazeni = get_slide_collision(i).get_collider()
			if narazeni.is_in_group("player"):
				queue_free()
				return
			print(narazeni.name)
