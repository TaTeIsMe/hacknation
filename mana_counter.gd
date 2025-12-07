extends TextureProgressBar

@export var mana_value: float = 100

var charging: bool = false
var spell_kind: SpellButton.SpellKind

var initial_mana
var final_mana

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.value = mana_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(charging && mana_value > 0):
		mana_value -= 10.0 * delta
		self.value = lerp(27, 80, mana_value / 100)
		final_mana = self.value
	if(mana_value < 0):
		mana_value = 0
		charging = false
		$AudioStreamPlayer.stream = preload("res://Resources/Sounds/mongolian.ogg")
		$AudioStreamPlayer.play()
		#$"./EvilWizard".visible = true
		$"../".spell_release_power.emit(spell_kind, initial_mana - final_mana)

func _on_menu_control_spell_down(kind: SpellButton.SpellKind) -> void:
	charging = true
	initial_mana = mana_value
	spell_kind = kind

func _on_menu_control_spell_release() -> void:
	charging = false
	$"../".spell_release_power.emit(spell_kind, initial_mana - final_mana)
