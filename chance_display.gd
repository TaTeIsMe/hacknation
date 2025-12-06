extends Control

@export var spell_accuracy: int = 20
@export var luck_value: int = 60

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_node("Chance Display").text = str(spell_accuracy + luck_value) + "%"
	self.get_node("Chance Display").get_node("Chance Details").text = "(%s%% + [color=green]%s%%[/color])" % [spell_accuracy, luck_value]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
