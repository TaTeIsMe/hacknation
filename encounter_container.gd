extends Node2D


const ENCOUNTER = preload("res://encounter.tscn")
signal enemy_died
signal enemy_attacked(damage:int)
signal boss_music(is_boss: bool)
signal enemy_turn_passed()

var encounter

func _on_navigator_start_encounter(passed_encounter: Encounter) -> void:
	if(passed_encounter is Wizard):
		boss_music.emit(true)
	encounter = passed_encounter
	encounter.enemy_died.connect(_on_enemy_ded)
	self.add_child(encounter)
	pass_turn()

func _on_enemy_ded()-> void:
	if encounter is Wizard:
		print(encounter)
		$"../EvilWizard".visible = true
		$"../winlabel".visible = true
	remove_child(encounter)
	enemy_died.emit()
	
func attack_enemy(_kind,damage: int):
	if encounter:
		encounter.take_damage(damage)

func enemy_attack():
	if encounter:
		enemy_attacked.emit(encounter.damage)
	
func take_turn():
	enemy_attack()
	if encounter:
		encounter.attack_animation()
		$Timer.start()
	else: pass_turn()

func pass_turn():
	enemy_turn_passed.emit()


func _on_timer_timeout() -> void:
	pass_turn()	
