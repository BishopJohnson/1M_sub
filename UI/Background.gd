extends ParallaxBackground
class_name Background
## Class for handling background images for events.

## The texture node for displaying the background.
@export var background_texture: TextureRect

#region Node

func _ready() -> void:
	var floor: int = PlayerManager.player_position[1]
	
	if not MapManager.map_area_dictionary.has(floor):
		printerr("The floor ", floor, " does not have an associated tree area")
		return
	
	var area: GlobalEnums.TreeAreaFlag = MapManager.map_area_dictionary[floor]
	var event_type: GlobalEnums.EventTypeFlag = SceneManager.current_event
	var database: EventBackgroundDatabase = GlobalDatabase.backgrounds
	
	match event_type:
		GlobalEnums.EventTypeFlag.Mob:
			background_texture.texture = database.next_combat_bg(area).texture
		_:
			# TODO: Get backgrounds that are specific to the area and event.
			background_texture.texture = database.get_backgrounds()[0].texture


#endregion Node
