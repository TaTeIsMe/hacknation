extends Node2D
# todo: przetestować zakęty, maska na minmapę, odddzielić minimapę
# obrót minimapy, czarny syf 
var head = Room.new(
		null, 
		null, 
	Room.new(
		null,
		null,
		Room.new(
			null,
			Room.new(
				Room.new(),
				null,
				Room.new(Room.new(
					null,
					Room.new(
						Room.new(),
						null,
						Room.new(null,null,null,Room.EncounterRoom.new(Encounter.EnemyKind.Wizard))
					),
					null,
					Room.EncounterRoom.new(Encounter.EnemyKind.Minotaur)
				)
			)
			),
			null,
			Room.EncounterRoom.new(Encounter.EnemyKind.Glucior)
		)
	), 
)

signal start_encounter(kind: Encounter.EnemyKind)

var position_stack: Array = [[head, Vector2i.LEFT, Vector2i.ZERO]]

const start_tile = Vector2i(6,3)
const gamba_tile = Vector2i(5,3)
const treasure_tile = Vector2i(5,2)
const battle_tile = Vector2i(5,1)
const wizard_tile = Vector2i(5,0)
const visited_tile = Vector2i(0,0)
const unvisited_tile = Vector2i(1,0)

func get_current_room() -> Room:
	return self.position_stack[-1][0]
	
func get_current_orientation() -> Vector2i:
	return self.position_stack[-1][1]
	
func get_current_position() -> Vector2i:
	return self.position_stack[-1][2]

func update_scene():
	var room = self.get_current_room()
		
	print(self.get_current_position())
	print(self.get_current_orientation())
	$BackButton.disabled = self.position_stack.size() <= 1
	$BackButton.visible = self.position_stack.size() > 1
	
	$RightButton.disabled = self.get_current_room().right == null
	$FrontButton.disabled = self.get_current_room().front == null
	$LeftButton.disabled = self.get_current_room().left == null
	$RightButton.visible = self.get_current_room().right != null
	$FrontButton.visible = self.get_current_room().front != null
	$LeftButton.visible = self.get_current_room().left != null
	
	if room.contents is Room.EncounterRoom:
		start_encounter.emit(room.contents.enemy_kind)
		$FrontButton.disabled = true
		$LeftButton.disabled = true
		$RightButton.disabled = true
		$BackButton.disabled = true
	

	for i in range($Node2D/Decorations.get_children().size()):
		$Node2D/Decorations.get_children()[i].visible = room.decorations[i] != Room.Decoration.NO
		$Node2D/Decorations.get_children()[i].flip_h = room.decorations[i] == Room.Decoration.FLIPPED
	
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
	$Minimap.update_minimap(self.head, room, -self.get_current_position())

func _ready() -> void:
	self.head.visited = true
	self.update_scene()
	pass # Replace with function body.
	
func rotate_right(vec: Vector2i) -> Vector2i:
	return Vector2i(-vec.y, vec.x)

# Rotate left (counter-clockwise) 90°
func rotate_left(vec: Vector2i) -> Vector2i:
	return Vector2i(vec.y, -vec.x)
	
func _go(where: String) -> void:
	if where == "back":
		if self.position_stack.size() > 1:
			self.position_stack.pop_back()
	elif where == "right":
		var orientation = rotate_right(self.get_current_orientation())
		self.position_stack.push_back([
			self.get_current_room().right, 
			orientation,
			self.get_current_position() + orientation
			])
	elif where == "front":
		self.position_stack.push_back([
			self.get_current_room().front, 
			self.get_current_orientation(),
			self.get_current_position() + self.get_current_orientation()
			])
	elif where == "left":
		var orientation = rotate_left(self.get_current_orientation())
		self.position_stack.push_back([
			self.get_current_room().left, 
			orientation,
			self.get_current_position() + orientation
			])
	else:
		printerr("gdzie ty idziesz?? ", where)
	self.get_current_room().visited = true
	self.update_scene()
		
		


func _on_encounter_container_enemy_died() -> void:
	var room = self.get_current_room()
	room.contents = null
	$BackButton.disabled = self.position_stack.size() <= 1
	$BackButton.visible = self.position_stack.size() > 1
	
	$RightButton.disabled = self.get_current_room().right == null
	$FrontButton.disabled = self.get_current_room().front == null
	$LeftButton.disabled = self.get_current_room().left == null
	$RightButton.visible = self.get_current_room().right != null
	$FrontButton.visible = self.get_current_room().front != null
	$LeftButton.visible = self.get_current_room().left != null
