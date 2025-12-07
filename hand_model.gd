extends Node2D

var cast_animation = preload("res://Styles/hand_animation_cast.tres")
var spell_animation = preload("res://Styles/fire_animation.tres")
var hand_state: SpriteFrames = preload("res://Styles/hand_animation_idle.tres")
@export var min_position: Vector2 = Vector2(750, 480)
@export var max_position: Vector2 = Vector2(800, 500) 

signal is_charging(charge: bool)
signal done_charging(charge: bool)
signal attack_complete

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_node("Hand Sprite").set_sprite_frames(hand_state)
	self.get_node("Hand Sprite").animation = "default"
	self.get_node("Hand Sprite").play()

func cast_a_spell(spell_type: SpellButton.SpellKind):
	$"Hand Sprite".set_sprite_frames(cast_animation)
	$"Hand Sprite".frame = 0
	$"Hand Sprite".animation_looped.connect( _animation_done, ConnectFlags.CONNECT_ONE_SHOT)
	$"Hand Sprite".play()
	is_charging.emit(true)
	match spell_type:
		SpellButton.SpellKind.Fire:
			spell_animation = preload("res://Styles/fire_animation.tres")
			$"Spell Sprite".visible = true
			$"Spell Sprite".set_sprite_frames(spell_animation)	
			$"Spell Sprite".frame = 0
			$"Spell Sprite".animation_looped.connect( _animate_spell_done, ConnectFlags.CONNECT_ONE_SHOT)
			$"Spell Sprite".play()
		SpellButton.SpellKind.Ice:
			spell_animation = preload("res://Styles/ice_animation.tres")
			$"Spell Sprite".visible = true
			$"Spell Sprite".set_sprite_frames(spell_animation)	
			$"Spell Sprite".frame = 0
			$"Spell Sprite".animation_looped.connect( _animate_spell_done, ConnectFlags.CONNECT_ONE_SHOT)
			$"Spell Sprite".play()
		SpellButton.SpellKind.Spark:
			spell_animation = preload("res://Styles/spark_animation.tres")
			$"Spell Sprite".visible = true
			$"Spell Sprite".set_sprite_frames(spell_animation)	
			$"Spell Sprite".frame = 0
			$"Spell Sprite".animation_looped.connect( _animate_spell_done, ConnectFlags.CONNECT_ONE_SHOT)
			$"Spell Sprite".play()
		SpellButton.SpellKind.Fireball:
			spell_animation = preload("res://Styles/fireball_animation.tres")
			$"Spell Sprite".visible = true
			$"Spell Sprite".set_sprite_frames(spell_animation)	
			$"Spell Sprite".frame = 0
			$"Spell Sprite".animation_looped.connect( _animate_spell_done, ConnectFlags.CONNECT_ONE_SHOT)
			$"Spell Sprite".play()
			
func _animation_done():
	$"Hand Sprite".set_sprite_frames(hand_state)
	self.get_node("Hand Sprite").animation = "default"
	$"Hand Sprite".frame = 0
	$"Hand Sprite".play()
	done_charging.emit(true)
	
func _animate_spell_done():
	$"Spell Sprite".visible = false
	self.attack_complete.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	var target_position = lerp(self.position, mouse_pos, 0.05 * delta)

	target_position.x = clamp(target_position.x, min_position.x, max_position.x)
	target_position.y = clamp(target_position.y, min_position.y, max_position.y)
	
	self.position = target_position

func begin_charging():
	$"Charging Sprite".visible = true
	$"Hand Sprite".animation = "charging"
	$"Charging Sprite".play()

func _on_node_2d_spell_cast(kind: SpellButton.SpellKind, power: float) -> void:
	$"Charging Sprite".visible = false
	self.cast_a_spell(kind)
	pass # Replace with function body.


func _on_node_2d_spell_down(kind: SpellButton.SpellKind) -> void:
	begin_charging() # Replace with function body.
