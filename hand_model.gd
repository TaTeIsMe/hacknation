extends Node2D

var cast_animation = preload("res://Styles/hand_animation_cast.tres")
var hand_state: SpriteFrames = preload("res://Styles/hand_animation_idle.tres")
@export var min_position: Vector2 = Vector2(750, 480)
@export var max_position: Vector2 = Vector2(800, 500) 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_node("Hand Sprite").set_sprite_frames(hand_state)
	self.get_node("Hand Sprite").play()

func cast_a_spell():
	$"Hand Sprite".set_sprite_frames(cast_animation)
	$"Hand Sprite".frame = 0
	$"Hand Sprite".animation_looped.connect( _animation_done, ConnectFlags.CONNECT_ONE_SHOT)
	$"Hand Sprite".play()
	
func _animation_done():
	$"Hand Sprite".set_sprite_frames(hand_state)
	$"Hand Sprite".frame = 0
	$"Hand Sprite".play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	var target_position = lerp(self.position, mouse_pos, 0.05 * delta)

	target_position.x = clamp(target_position.x, min_position.x, max_position.x)
	target_position.y = clamp(target_position.y, min_position.y, max_position.y)
	
	self.position = target_position


func _on_node_2d_spell_cast(kind: SpellButton.SpellKind) -> void:
	self.cast_a_spell()
	pass # Replace with function body.
