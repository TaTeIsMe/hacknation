extends Node2D


const ENCOUNTER = preload("res://encounter.tscn")

func _on_navigator_start_encounter(kind: Encounter.EnemyKind) -> void:
	var encounter = ENCOUNTER.instantiate()
	encounter.enemy_kind = kind
	self.add_child(encounter)
