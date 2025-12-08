extends Node
class_name Character

@onready var luck = 30
enum SpellKind {
	Fire,
	Ice,
	Spark,
	Fireball
}

signal luck_changed(new_luck:int)
signal spell_cast(kind:SpellKind,damage:int)
signal character_turn_passed()

func cast_spell(kind : Character.SpellKind):
	var rng = RandomNumberGenerator.new()
	var rng_val = rng.randf_range(0,100) 
	match kind:
		SpellKind.Fire:
			if rng_val - luck > 100.0/4.0: 
				pass_turn()
			else:
				spell_cast.emit(kind, 20)
				pass_turn()
		SpellKind.Ice:
			if rng_val - luck > 100.0/8.0: 
				pass_turn()
			else:
				spell_cast.emit(kind, 100)
				pass_turn()
		SpellKind.Spark:
			if rng_val - luck > 100.0/20.0: 
				pass_turn()
			else:
				spell_cast.emit(kind, 200)
				pass_turn()
		SpellKind.Fireball:
			if rng_val - luck > 100.0/1000.0: 
				pass_turn()
			else:
				spell_cast.emit(kind, 2000)
				pass_turn()

func _on_node_2d_spell_button_clicked(kind: Character.SpellKind) -> void:
	cast_spell(kind)

func pass_turn():
	character_turn_passed.emit()

func take_damage(damage: int):
	luck -= damage
	luck_changed.emit(luck)
