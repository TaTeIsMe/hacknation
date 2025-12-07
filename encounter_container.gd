extends Node2D


const ENCOUNTER = preload("res://encounter.tscn")
signal enemy_died

func _on_navigator_start_encounter(kind: Encounter.EnemyKind) -> void:
	var encounter = ENCOUNTER.instantiate()
	encounter.enemy_kind = kind
	encounter.enemy_died.connect(_on_enemy_ded)
	self.add_child(encounter)

func _on_enemy_ded()-> void:
	for n in get_children():
		remove_child(n)
	enemy_died.emit()
	
func attack_enemy():
	for child in self.get_children():
		child.take_damage(10)
