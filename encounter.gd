extends Node2D

class_name Encounter

enum EnemyKind {
	Glucior,
	Minotaur,
	Wizard
}

@export var encounter_hp: float = 100.0
@export var enemy_kind: EnemyKind = EnemyKind.Glucior

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match enemy_kind:
		EnemyKind.Glucior:
			var sprite: Texture2D = preload("res://Resources/slime.png")
			self.get_node("Encounter Sprite").texture = sprite
			self.get_node("Encounter Label").text = "Glucior"
		EnemyKind.Minotaur:
			var sprite: Texture2D = preload("res://Resources/minotour.png")
			self.get_node("Encounter Sprite").texture = sprite
			self.get_node("Encounter Label").text = "Gigancka\nMućka"
		EnemyKind.Wizard:
			var sprite: Texture2D = preload("res://Resources/wizard.png")
			self.get_node("Encounter Sprite").texture = sprite
			self.get_node("Encounter Label").text = "Wiedźmak\nStrahenstein"
