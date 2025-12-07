extends Control

@export var spell_accuracy: int = 20
@export var spell_power: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_node("Spell Info").get_node("Acc Value").text = str(spell_accuracy) + "%"
	self.get_node("Spell Info").get_node("Power Value").text = str(spell_power) + "%"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
