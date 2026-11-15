extends Node2D
signal vsichni_kaktusove_zabiti

@export var kaktus_scena: PackedScene

var oblast: int = 1
var druha_oblast_hotova: bool = false
var zbyva_kaktusu: int = 0
var brana_otevrena: bool = false

func _ready() -> void:
	for kaktus in get_tree().get_nodes_in_group("enemy"):
		zbyva_kaktusu += 1
		kaktus.connect("kaktus_zabity", _on_kaktus_zabity)
func _on_kaktus_zabity() -> void:
	zbyva_kaktusu -= 1

	if zbyva_kaktusu == 0:
		if oblast == 1:
			brana_otevrena = true
			vsichni_kaktusove_zabiti.emit()
		else:
			druha_oblast_hotova = true


func _on_win_zone_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	if oblast != 1 or not brana_otevrena:
		return

	if kaktus_scena == null:
		push_error("Není nastavená scéna kaktusu!")
		return

	oblast = 2

	for marker in [$Spawn2A, $Spawn2B, $Spawn2C]:
		var kaktus = kaktus_scena.instantiate() as CharacterBody2D

		kaktus.position = marker.position
		kaktus.set("bullet_scene", preload("res://bullet.tscn"))

		add_child(kaktus)

		kaktus.connect("kaktus_zabity", _on_kaktus_zabity)
		zbyva_kaktusu += 1
