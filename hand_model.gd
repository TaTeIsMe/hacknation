extends Node2D

@export var hand_state: SpriteFrames = preload("res://Styles/hand_animation_idle.tres")
@export var min_position: Vector2 = Vector2(750, 480)
@export var max_position: Vector2 = Vector2(800, 500) 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_node("Hand Sprite").set_sprite_frames(hand_state)
	self.get_node("Hand Sprite").play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	
	var target_position = lerp(self.position, mouse_pos, 0.05 * delta)

	target_position.x = clamp(target_position.x, min_position.x, max_position.x)
	target_position.y = clamp(target_position.y, min_position.y, max_position.y)
	
	self.position = target_position
