extends TextureProgressBar

@export var mana_value: int = 70

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = mana_value
	self.get_node("Mana Value").text = "%s%%" % mana_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
