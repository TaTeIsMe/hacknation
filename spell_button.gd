extends Button

@export var button_text: String = "Button"
@export var spell_accuracy: int = 20
@export var spell_power: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.text = button_text

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
