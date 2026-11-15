extends Node2D

@onready var brana: AnimatedSprite2D = $AnimatedSprite2D
@onready var starakolize: CollisionShape2D = $zmizejicikolize
@onready var noko: CollisionShape2D = $novakolize

func _ready() -> void:
	get_tree().current_scene.vsichni_kaktusove_zabiti.connect(otevri_branu)

func otevri_branu() -> void:
	brana.play("otevreni")
	starakolize.set_deferred("disabled", true)
	noko.set_deferred("disabled", false)
