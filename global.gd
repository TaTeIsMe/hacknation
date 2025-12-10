extends Node

signal luck_changed(new_luck:int)
var luck = 30:
	set(value):
		luck = value
		luck_changed.emit(value)
