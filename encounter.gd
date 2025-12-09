extends Node2D
class_name Encounter

signal enemy_died
@export var encounter_hp: float = 100.0
@export var damage:float = 2

func take_damage(damage: int)-> void:
	if($AudioStreamPlayer.stream != preload("res://Resources/Sounds/hurt1.ogg")):
		$AudioStreamPlayer.stream = preload("res://Resources/Sounds/hurt1.ogg")
	else: $AudioStreamPlayer.stream = preload("res://Resources/Sounds/hurt2.ogg")
	$AudioStreamPlayer.play()
	encounter_hp -= damage
	if encounter_hp <= 0:
		enemy_died.emit()

func attack_animation():
	$AnimatedSprite2D.play("attack")

func default_animation():
	$AnimatedSprite2D.play("default")
