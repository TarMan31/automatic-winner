extends CanvasLayer

func _ready() -> void:
	$Button.pressed.connect(_on_button_pressed)

func show_death() -> void:
	show()
	$faah.play()
	get_tree().paused = true

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
