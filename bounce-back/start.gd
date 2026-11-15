extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true
	$Button.pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	get_tree().paused = false
	queue_free()
