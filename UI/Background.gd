extends ParallaxBackground
class_name Background
## Class for handling background images for events.

## The texture node for displaying the background.
@export var background_texture: TextureRect

#region Node

func _ready() -> void:
	# TODO: Get area based on whichever manager has that data.
	var area: GlobalEnums.TreeAreaFlag = GlobalEnums.TreeAreaFlag.All
	var bg: EventBackground = GlobalDatabase.backgrounds.next_combat_bg(area)
	background_texture.texture = bg.texture


#endregion Node
