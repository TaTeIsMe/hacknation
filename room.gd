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


var left: Room = null
var right: Room = null
var front: Room = null
var visited = false
var decorations
var contents: RoomContents = null

func _init(l=null,f=null,r=null,c=null):
	self.left = l
	self.right = r
	self.front = f
	self.contents = c
	self.decorations = [
		randf() < 0.1,
		randf() < 0.1,
		randf() < 0.1,
		randf() < 0.1,
	]
