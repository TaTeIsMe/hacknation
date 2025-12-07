extends Button

class_name SpellButton

enum SpellKind {
	Fire,
	Ice,
	Spark,
	Fireball
}

@export var spell_kind: SpellKind = SpellKind.Fire
@export var spell_accuracy: float = 20.0
@export var spell_power: float = 10.0

var tween_stylebox:StyleBoxFlat
var styleboxes:Dictionary = {}
var current_state = BaseButton.DRAW_NORMAL

var tween:Tween


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match spell_kind:
		SpellKind.Fire:
			self.text = "Oktażar"
		SpellKind.Ice:
			self.text = "Tetraszron"
		SpellKind.Spark:
			self.text = "Ikosagrom"
		SpellKind.Fireball:
			self.text = "Kula Ognia"
			
	self.pressed.connect(_button_pressed)
	self.button_down.connect(_button_down)
	self.button_up.connect(_button_release)
	
	tween_stylebox = get_theme_stylebox('normal').duplicate()
	
	styleboxes[BaseButton.DRAW_NORMAL] = get_theme_stylebox('normal').duplicate()
	styleboxes[BaseButton.DRAW_HOVER] = get_theme_stylebox('hover').duplicate()
	styleboxes[BaseButton.DRAW_PRESSED] = get_theme_stylebox('pressed').duplicate()
	styleboxes[BaseButton.DRAW_HOVER_PRESSED] = get_theme_stylebox('pressed').duplicate()
	
	add_theme_stylebox_override('normal', tween_stylebox)
	add_theme_stylebox_override('hover', tween_stylebox)
	add_theme_stylebox_override('pressed', tween_stylebox)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(self.disabled == false):
		if get_draw_mode() != current_state:
			# If the draw mode changed
			current_state = get_draw_mode()
			# Kill the running tween
			if tween and tween.is_running():
				tween.kill()
			# And create a new one
			tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).set_parallel()
			# That tweens some properties of our tween stylebox to the target stylebox
			# depending on the current state
			var target = styleboxes[current_state] as StyleBoxFlat
			tween.tween_property(tween_stylebox, "bg_color", target.bg_color, 0.2)
			tween.tween_property(tween_stylebox, "border_color", target.border_color, 0.2)

func _button_pressed():
	$"../../".spell_cast.emit(spell_kind)
	#spells_vars.emit(spell_kind)

func _button_down():
	$"../../".spell_down.emit(spell_kind)

func _button_release():
	$"../../".spell_release.emit()
	
