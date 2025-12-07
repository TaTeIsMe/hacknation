extends Node2D

func update_minimap(room: Room, wizard_room: Room, pos = Vector2i.ZERO, orientation=Vector2i.UP):
	$Icons.erase_cell(pos)
	
	if room.visited && room.contents != null && room.contents.tile_pos() != Vector2i.ZERO:
		$Icons.set_cell(pos, 0, room.contents.tile_pos())

	var idx = 0;
	if orientation == Vector2i.DOWN:
		idx = 1
	elif orientation == Vector2i.LEFT:
		idx = 2
	elif orientation == Vector2i.UP:
		idx = 3
	idx += 1
	idx %= 4
	
	var w = [Vector2i(7,0), Vector2i(5,0),Vector2i(6,0),Vector2i(4,0)]
	if room == wizard_room:
		$Icons.set_cell(pos, 0, w[idx])
	
	var mask = [room.right != null, room.front != null, room.left != null]
	var t = [Vector2i(3,0), Vector2i(3,1), Vector2i(2,1), Vector2i(2,0)]
	var l = [Vector2i(1,1), Vector2i(0,1), Vector2i(0,2), Vector2i(1,2)]
	var d = [Vector2i(3,2), Vector2i(3,3), Vector2i(2,3), Vector2i(2,2)]
	var s = [Vector2i(1,3), Vector2i(0,3)]
	var b = [Vector2i(4,3), Vector2i(4,2), Vector2i(5,2), Vector2i(5,3)]
	if !room.visited:
		$BG.set_cell(pos, 0, b[idx])
		return
	if mask == [true, true, true]:
		$BG.set_cell(pos, 0, Vector2i(6,3))
	elif mask == [true, false, true]:
		$BG.set_cell(pos, 0, t[idx])
	elif mask == [true, false, false] || mask == [false, false, true] :
		$BG.set_cell(pos, 0, l[idx])
	elif mask == [false, false, false]:
		$BG.set_cell(pos, 0, d[idx])
	elif mask == [false, true, false]:
		$BG.set_cell(pos, 0, s[idx% 2])
		
	if room.left != null:
		var left_dir = Vector2i(orientation.y, -orientation.x)
		self.update_minimap(room.left, wizard_room, pos + left_dir, left_dir)
	if room.right != null:
		var right_dir = Vector2i(-orientation.y, orientation.x)
		self.update_minimap(room.right,wizard_room,  pos + right_dir, right_dir)
	if room.front != null:
		self.update_minimap(room.front,wizard_room,  pos + orientation, orientation)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
