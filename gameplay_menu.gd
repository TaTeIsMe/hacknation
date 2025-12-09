extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

signal spell_button_clicked(kind: Character.SpellKind)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.get_node("Spell List").get_children().map(func(spell): if(spell.is_hovered()):
		get_node("Spell Info/Spell Info/Acc Value").text = str(spell.spell_accuracy) + "%")
	self.get_node("Spell List").get_children().map(func(spell): if(spell.is_hovered()):
		get_node("Spell Info/Spell Info/Power Value").text = str(spell.spell_power) + "%")

func _on_spell_1_button_down() -> void:
	spell_button_clicked.emit(Character.SpellKind.Fire)

func _on_spell_2_button_down() -> void:
	spell_button_clicked.emit(Character.SpellKind.Ice)

func _on_spell_3_button_down() -> void:
	spell_button_clicked.emit(Character.SpellKind.Spark)

func _on_spell_4_button_down() -> void:
	spell_button_clicked.emit(Character.SpellKind.Fireball)

func disable_spells():
	$"Spell List".get_children().map(func(spell): spell.disabled = true)

func enable_spells():
	$"Spell List".get_children().map(func(spell): spell.disabled = false)

func change_mana(mana:int):
	$"Mana counter".value = mana
