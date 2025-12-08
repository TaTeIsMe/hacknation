extends TextureProgressBar

@export var mana_value: float = 30

var charging: bool = false
var spell_kind: SpellButton.SpellKind

var initial_mana
var final_mana

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = mana_value


func _on_menu_control_spell_down(kind: SpellButton.SpellKind) -> void:
	charging = true
	initial_mana = mana_value
	spell_kind = kind

func _on_menu_control_spell_release() -> void:
	charging = false
	$"../".spell_release_power.emit(spell_kind, initial_mana - final_mana)
