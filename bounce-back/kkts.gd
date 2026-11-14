extends CharacterBody2D

@export var bullet_scene: PackedScene

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
				narazeni.take_damage(100)
				queue_free()
				return
			

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	if player == null or bullet_scene == null:
		return
	var bullet = bullet_scene.instantiate() as Area2D
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = global_position
	bullet.call("aim_at", player.global_position)
	
	
