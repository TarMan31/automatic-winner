extends Node2D

signal vsichni_kaktusove_zabiti

var zbyva_kaktusu: int = 0


func _ready() -> void:
	for kaktus in get_tree().get_nodes_in_group("enemy"):
		zbyva_kaktusu += 1
		kaktus.connect("kaktus_zabity", _on_kaktus_zabity)


func _on_kaktus_zabity() -> void:
	zbyva_kaktusu -= 1
	print("Zbývá kaktusů: ", zbyva_kaktusu)

	if zbyva_kaktusu == 0:
		print("Vsichni kaktusi jsou mrtvi!")
		vsichni_kaktusove_zabiti.emit()
