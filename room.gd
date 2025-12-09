class_name Room

class RoomContents:
	func tile_pos() -> Vector2i:
		return Vector2i.ZERO
	
	func sprite_texture() -> Texture2D:
		return null

class RoomLoot extends RoomContents:
	func tile_pos() -> Vector2i:
		return Vector2i(5,1)
		
	func sprite_texture() -> Texture2D:
		return preload("res://image.png")
		
class EncounterRoom extends RoomContents:
	var encounter: Encounter
	
	func tile_pos() -> Vector2i:
		return Vector2i(5,1)
		
	func sprite_texture() -> Texture2D:
		return null
		
	func _init(encounter: Encounter):
		self.encounter = encounter

var left: Room = null
var right: Room = null
var front: Room = null
var visited = false
var decorations
var contents: RoomContents = null

enum Decoration {NO,YES,FLIPPED}
func get_random_decoratoin() -> Decoration:
	var random_value = randf() 
	if random_value < 0.1:       
		return Decoration.YES
	elif random_value < 0.2: 
		return Decoration.FLIPPED
	else:                        
		return Decoration.NO

func _init(l=null,f=null,r=null,c=null):
	self.left = l
	self.right = r
	self.front = f
	self.contents = c
	self.decorations = [
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
		get_random_decoratoin(),
	]
