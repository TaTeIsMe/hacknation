extends Node
class_name Character

enum SpellKind {
	Fire,
	Ice,
	Spark,
	Fireball
}

signal character_took_damage(damage:int)
signal spell_cast(kind:SpellKind,damage:int)
signal spell_hit(kind:SpellKind,damage:int)
signal character_turn_passed()

func cast_spell(kind : Character.SpellKind):
	spell_cast.emit()
	var rng = RandomNumberGenerator.new()
	var rng_val = rng.randf_range(0,100) 
	match kind:
		SpellKind.Fire:
			if rng_val - Global.luck > 100.0/4.0: 
				$PassTurnTimer.start()
			else:
				spell_hit.emit(kind, 20)
		SpellKind.Ice:
			if rng_val - Global.luck > 100.0/8.0: 
				$PassTurnTimer.start()
			else:
				spell_hit.emit(kind, 100)
		SpellKind.Spark:
			if rng_val - Global.luck > 100.0/20.0: 
				$PassTurnTimer.start()
			else:
				spell_hit.emit(kind, 200)
		SpellKind.Fireball:
			if rng_val - Global.luck > 100.0/1000.0: 
				$PassTurnTimer.start()
			else:
				spell_hit.emit(kind, 2000)
	$PassTurnTimer.start()

func pass_turn():
	character_turn_passed.emit()

func take_damage(damage: int):
	#delay for correct damage blink timing
	await get_tree().create_timer(0.5).timeout
	character_took_damage.emit()
	Global.luck -= damage
	if Global.luck < 0:
		$"../Lose".visible = true
