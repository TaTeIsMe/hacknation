extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.get_node("Spell List").get_children().map(func(spell): if(spell.is_hovered()):
		get_node("Spell Info/Spell Info/Acc Value").text = str(spell.spell_accuracy))
	pass
