extends Node
class_name Database
## Class for holding databases of resources.

## The database holding event backgrounds.
@export var backgrounds: EventBackgroundDatabase

#region Node

func _ready() -> void:
	if backgrounds == null:
		print("backgrounds var in ", name, " is null")
	else:
		backgrounds.load()

#endregion Node
