extends CharacterBody2D

@export var speed : int = 250
@export var max_zivoty: int = 100
@onready var mrtvej = $deathscreen

var health: int = max_zivoty

@onready var zivotyted: ProgressBar = $CanvasLayer/Zivoty
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
	zivotyted.max_value = max_zivoty
	zivotyted.value = health

func take_damage(amount: int) -> void:
	health -= amount
	zivotyted.value = health
	print("Zdraví: ", health)
	if health <= 0:
		mrtvej.show_death()
		
	


func _on_shield_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.has_method("bounce_from_shield"):
		body.call("bounce_from_shield", global_position)
