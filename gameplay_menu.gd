extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

signal spell_cast(kind: SpellButton.SpellKind)
signal spell_down(kind: SpellButton.SpellKind)
signal spell_release()
signal spell_release_power(spell_kind: SpellButton.SpellKind, power: float)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.get_node("Spell List").get_children().map(func(spell): if(spell.is_hovered()):
		get_node("Spell Info/Spell Info/Acc Value").text = str(spell.spell_accuracy) + "%")
	pass


func _on_navigator_start_encounter(kind: Encounter.EnemyKind) -> void:
	$"HP Bar".visible = false


func _on_hand_model_is_charging(charge: bool) -> void:
	$"Spell List".get_children().map(func(spell): spell.disabled = true)


func _on_hand_model_done_charging(charge: bool) -> void:
	$"Spell List".get_children().map(func(spell): spell.disabled = false)
