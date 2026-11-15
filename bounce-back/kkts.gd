extends CharacterBody2D

@export var bullet_scene: PackedScene

@export var speed: float = 50
@export var rychlost_strely: float = 400
@export var max_zivoty: int = 3
var zivoty: int

var stit_cekani: float = 0.0
var cas_knockbacku: float = 0.0
var smer_knockbacku: Vector2 = Vector2.ZERO

func _ready() -> void:
	add_to_group("enemy")
	zivoty = max_zivoty
	
func _physics_process(delta: float) -> void:
	stit_cekani = maxf(0.0, stit_cekani - delta)
	if cas_knockbacku > 0.0:
		cas_knockbacku -= delta
		velocity = smer_knockbacku * 400.0
		move_and_slide()
		return

	var player = get_tree(). get_first_node_in_group("player")
	
	if player:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		for i in get_slide_collision_count():
			var narazeni = get_slide_collision(i).get_collider()
			if narazeni.name == "ShieldBlocker":
				bounce_from_shield(narazeni.global_position)
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
	
	
func bounce_from_shield(shield_position: Vector2) -> void:
	if stit_cekani > 0.0:
		return

	stit_cekani = 0.25
	cas_knockbacku = 0.25
	smer_knockbacku = (global_position - shield_position).normalized()

func bum_zasah() -> void:
	zivoty -= 1

	if zivoty <= 0:
		var zvuk = get_tree().current_scene.get_node_or_null("EnemyDeathSound")
		if zvuk:
			zvuk.play()
		queue_free()
