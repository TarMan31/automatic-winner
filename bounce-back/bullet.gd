extends Area2D

var speed : float = 300.0
var direction : Vector2 = Vector2.ZERO   # nastaví ji ten, kdo střílí

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
