extends Node2D

var head = Room.new(Room.new(), null, Room.new(Room.new(),null,Room.new(Room.new(null,Room.new())), Room.RoomLoot.new()))
var position_stack: Array = [head]

const start_tile = Vector2i(6,3)
const gamba_tile = Vector2i(5,3)
const treasure_tile = Vector2i(5,2)
const battle_tile = Vector2i(5,1)
const wizard_tile = Vector2i(5,0)
const visited_tile = Vector2i(0,0)
const unvisited_tile = Vector2i(1,0)

var poop = false

func update_scene():
	$BackButton.disabled = self.position_stack.size() <= 1
	$BackButton.visible = self.position_stack.size() > 1
	
	$RightButton.disabled = self.position_stack[-1].right == null
	$FrontButton.disabled = self.position_stack[-1].front == null
	$LeftButton.disabled = self.position_stack[-1].left == null
	$RightButton.visible = self.position_stack[-1].right != null
	$FrontButton.visible = self.position_stack[-1].front != null
	$LeftButton.visible = self.position_stack[-1].left != null
	

	var room = self.position_stack[-1]	
	for i in range(4):
		$Node2D/Decorations.get_children()[i].visible = room.decorations[i]
	
	if room.contents != null:
		var texture = room.contents.sprite_texture()
		if texture != null:
			$Node2D/Wygrana.texture = texture
			$Node2D/Wygrana.visible = true
		else:
			$Node2D/Wygrana.visible = false
	else:
		$Node2D/Wygrana.visible = false
			

	match [room.left != null, room.front != null, room.right != null]:
		[false, false, false]:
			$Node2D/Background.texture = preload("res://Resources/Corridors/wall.png")
		[true, false, false]:
			$Node2D/Background.texture = preload("res://Resources/Corridors/wall6.png")
		[false, true, false]:
			$Node2D/Background.texture = preload("res://Resources/Corridors/wall2.png")
		[false, false, true]:
			$Node2D/Background.texture = preload("res://Resources/Corridors/wall3.png")
		[true, true, false]:
			$Node2D/Background.texture = preload("res://Resources/Corridors/wall7.png")
		[true, false, true]:
			$Node2D/Background.texture = preload("res://Resources/Corridors/wall5.png")
		[false, true, true]:
			$Node2D/Background.texture = preload("res://Resources/Corridors/wall4.png")
		[true, true, true]:
			$Node2D/Background.texture = preload("res://Resources/Corridors/wall8.png")
	$Minimap.update_minimap(self.head, self.position_stack[-1])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.head.visited = true
	self.update_scene()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _go(where: String) -> void:
	if where == "back":
		if self.position_stack.size() > 1:
			self.position_stack.pop_back()
	elif where == "right":
		self.poop = !self.poop
		self.position_stack.push_back(self.position_stack[-1].right)
	elif where == "front":
		self.position_stack.push_back(self.position_stack[-1].front)
	elif where == "left":
		self.poop = !self.poop
		self.position_stack.push_back(self.position_stack[-1].left)
	else:
		printerr("gdzie ty idziesz?? ", where)
	self.position_stack[-1].visited = true
	self.update_scene()
		
		
