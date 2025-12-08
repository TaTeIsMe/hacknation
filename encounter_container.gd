extends Node2D


const ENCOUNTER = preload("res://encounter.tscn")
signal enemy_died
signal enemy_attacked(damage:int)
signal boss_music(is_boss: bool)
signal enemy_turn_passed()

var encounter

func _on_navigator_start_encounter(kind: Encounter.EnemyKind) -> void:
	if(kind == Encounter.EnemyKind.Wizard):
		boss_music.emit(true)
	encounter = ENCOUNTER.instantiate()
	encounter.enemy_kind = kind
	encounter.enemy_died.connect(_on_enemy_ded)
	self.add_child(encounter)
	pass_turn()

func _on_enemy_ded()-> void:
	remove_child(encounter)
	enemy_died.emit()
	
func attack_enemy(_kind,damage: int):
	if encounter:
		encounter.take_damage(damage)

func enemy_attack():
	if encounter:
		enemy_attacked.emit(encounter.damage)
	
func take_turn():
	$Timer.start()

func pass_turn():
	enemy_turn_passed.emit()


func _on_timer_timeout() -> void:
	enemy_attack()
	pass_turn()	
