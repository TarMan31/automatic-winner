extends Node2D
signal vsichni_kaktusove_zabiti

var zbyva_kaktusu: int = 0
var brana_otevrena: bool = false

func _ready() -> void:
	for kaktus in get_tree().get_nodes_in_group("enemy"):
		zbyva_kaktusu += 1
		kaktus.connect("kaktus_zabity", _on_kaktus_zabity)
func _on_kaktus_zabity() -> void:
	zbyva_kaktusu -= 1
	if zbyva_kaktusu == 0:
	
	if zbyva_kaktusu == 0:
		brana_otevrena = true	
		vsichni_kaktusove_zabiti.emit()


func _on_win_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and brana_otevrena:
		$WinUI/YouWin.show()
		get_tree().set_deferred("paused", true)
