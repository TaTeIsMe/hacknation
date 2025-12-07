extends Node2D

var cast_animation = preload("res://Styles/hand_animation_cast.tres")
var spell_animation = preload("res://Styles/fire_animation.tres")
var hand_state: SpriteFrames = preload("res://Styles/hand_animation_idle.tres")
@onready var min_position: Vector2 = self.position + Vector2(25,10)
@onready var max_position: Vector2 = self.position - Vector2(25,10)
@onready var is_charging_sequel = false

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
	
	if is_charging_sequel:
		$"Hand Sprite".position.y += sin(Time.get_ticks_msec()/10) * 10
		$"Charging Sprite".position.y += sin(Time.get_ticks_msec()/100) * 10

func begin_charging():
	is_charging_sequel = true
	$"Charging Sprite".visible = true
	$"Hand Sprite".animation = "charging"
	$"Charging Sprite".play()
	$"AudioStreamPlayer".stream = preload("res://Resources/Sounds/noise.ogg")
	$"AudioStreamPlayer".play()

func _on_node_2d_spell_cast(kind: SpellButton.SpellKind, power: float) -> void:
	$"AudioStreamPlayer".stop()
	is_charging_sequel = false
	$"Charging Sprite".visible = false
	self.cast_a_spell(kind)


func _on_node_2d_spell_down(kind: SpellButton.SpellKind) -> void:
	begin_charging()
