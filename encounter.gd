extends Node2D

class_name Encounter

enum EnemyKind {
	Glucior,
	Minotaur,
	Wizard
}

signal enemy_died
@export var encounter_hp: float = 100.0
@export var enemy_kind: EnemyKind = EnemyKind.Glucior
@export var damage:float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match enemy_kind:
		EnemyKind.Glucior:
			var sprite: Texture2D = preload("res://Resources/slime.png")
			self.get_node("Encounter Sprite").texture = sprite
			$AudioStreamPlayer.stream = preload("res://Resources/Sounds/wrrr.ogg")
			$AudioStreamPlayer.play()
		EnemyKind.Minotaur:
			var sprite: Texture2D = preload("res://Resources/minotour.png")
			self.get_node("Encounter Sprite").texture = sprite
			$AudioStreamPlayer.stream = preload("res://Resources/Sounds/goblin2.ogg")
			$AudioStreamPlayer.play()
		EnemyKind.Wizard:
			var sprite: Texture2D = preload("res://Resources/wizard.png")
			self.get_node("Encounter Sprite").texture = sprite
			$AudioStreamPlayer.stream = preload("res://Resources/Sounds/mongolian.ogg")
			$AudioStreamPlayer.play()

func take_damage(damage: int)-> void:
	if($AudioStreamPlayer.stream != preload("res://Resources/Sounds/hurt1.ogg")):
		$AudioStreamPlayer.stream = preload("res://Resources/Sounds/hurt1.ogg")
	else: $AudioStreamPlayer.stream = preload("res://Resources/Sounds/hurt2.ogg")
	$AudioStreamPlayer.play()
	encounter_hp -= damage
	if encounter_hp <= 0:
		enemy_died.emit()
