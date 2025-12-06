extends Node2D

class RoomLoot:
	func tile_pos() -> Vector2i:
		return Vector2i.ZERO

class Room:
	var left: Room = null
	var right: Room = null
	var front: Room = null
	var visited = false
	
	func _init(l=null,f=null,r=null):
		self.left = l
		self.right = r
		self.front = f
		
var head = Room.new(Room.new(), null, Room.new(Room.new(),null,Room.new(Room.new(null,Room.new()))))
var position_stack: Array = [head]

const start_tile = Vector2i(6,3)
const gamba_tile = Vector2i(5,3)
const treasure_tile = Vector2i(5,2)
const battle_tile = Vector2i(5,1)
const wizard_tile = Vector2i(5,0)
const visited_tile = Vector2i(0,0)
const unvisited_tile = Vector2i(1,0)

var poop = false

func update_minimap(room: Room, pos = Vector2i.ZERO, orientation=Vector2i.DOWN):
	$MinimapIcons.erase_cell(pos)
	if room == self.position_stack[-1]:
		$MinimapIcons.set_cell(pos, 0, wizard_tile)
		
	if room == head:
		$MinimapBG.set_cell(pos, 0, start_tile)
	elif room.visited:
		$MinimapBG.set_cell(pos, 0, visited_tile)
	else:
		$MinimapBG.set_cell(pos, 0, unvisited_tile)
		return;
		
	if room.left != null:
		var left_dir = Vector2i(-orientation.y, -orientation.x)
		self.update_minimap(room.left, pos + left_dir, left_dir)
	if room.right != null:
		var right_dir = Vector2i(orientation.y, orientation.x)
		self.update_minimap(room.right, pos + right_dir, right_dir)
	if room.front != null:
		self.update_minimap(room.front, pos + orientation, orientation)
	

func update_scene():
	$BackButton.disabled = self.position_stack.size() <= 1
	$BackButton.visible = self.position_stack.size() > 1
	
	$RightButton.disabled = self.position_stack[-1].right == null
	$FrontButton.disabled = self.position_stack[-1].front == null
	$LeftButton.disabled = self.position_stack[-1].left == null
	$RightButton.visible = self.position_stack[-1].right != null
	$FrontButton.visible = self.position_stack[-1].front != null
	$LeftButton.visible = self.position_stack[-1].left != null
	
	$Walloverlay.visible = false
	
	var room = self.position_stack[-1]
	match [room.left != null, room.front != null, room.right != null]:
		[false, false, false]:
			$Background.texture = preload("res://Resources/Corridors/wall.png")
		[true, false, false]:
			$Background.texture = preload("res://Resources/Corridors/wall6.png")
		[false, true, false]:
			$Background.texture = preload("res://Resources/Corridors/wall2.png")
		[false, false, true]:
			$Background.texture = preload("res://Resources/Corridors/wall3.png")
		[true, true, false]:
			$Background.texture = preload("res://Resources/Corridors/wall7.png")
		[true, false, true]:
			$Background.texture = preload("res://Resources/Corridors/wall5.png")
		[false, true, true]:
			$Background.texture = preload("res://Resources/Corridors/wall4.png")
		[true, true, true]:
			$Background.texture = preload("res://Resources/Corridors/wall8.png")
	self.update_minimap(self.head)

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
		
		
