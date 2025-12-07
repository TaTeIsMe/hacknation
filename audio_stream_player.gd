extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spell1_button_up() -> void:
	self.stream = preload("res://Resources/Sounds/pew.ogg")
	self.play()


func _on_spell_2_button_up() -> void:
	self.stream = preload("res://Resources/Sounds/zip.ogg")
	self.play()

func _on_spell_3_button_up() -> void:
	self.stream = preload("res://Resources/Sounds/zip.ogg")
	self.play()
	
func _on_spell_4_button_up() -> void:
	self.stream = preload("res://Resources/Sounds/zip.ogg")
	self.play()
