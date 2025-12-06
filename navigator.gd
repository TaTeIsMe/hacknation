extends Node2D

class Room:
	#var back: Room = null
	var left: Room = null
	var right: Room = null
	var front: Room = null
	#var pos: Vector2i
	#var orientation: Vector2i
	
	func _init(l=null,f=null,r=null):
		#self.pos = p
		#self.orientation = o
		#self.back = null
		
		self.left = l
		#if self.left != null:
			#self.left.back = self
			#var left_dir = Vector2i(-self.orientation.y, self.orientation.x)
			#self.left.pos = self.pos + left_dir
			#self.left.orientation = left_dir
			
		self.right = r
		#if self.right != null:
			#self.right.back = self
			#var right_dir = Vector2i(self.orientation.y, -self.orientation.x)
			#self.right.pos = self.pos + right_dir
			#self.right.orientation = right_dir
			
		self.front = f
		#if self.front != null:
			#self.front.back = self
			#self.front.pos = self.pos + self.orientation
			#self.front.orientation = self.orientation
	
var head = Room.new(Room.new(), null, Room.new(Room.new(),null,Room.new()))
var position_stack: Array = [head]

func update_minimap(room: Room, pos = Vector2i.ZERO, orientation=Vector2i.DOWN):
	if room == self.position_stack[-1]:
		$Minimap.set_cell(pos, 0, Vector2i(5,3))
	else:
		$Minimap.set_cell(pos, 0, Vector2i(0,0))

		
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
		self.position_stack.push_back(self.position_stack[-1].right)
	elif where == "front":
		self.position_stack.push_back(self.position_stack[-1].front)
	elif where == "left":
		self.position_stack.push_back(self.position_stack[-1].left)
	else:
		printerr("gdzie ty idziesz?? ", where)
	self.update_scene()
		
		
