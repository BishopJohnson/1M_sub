extends Resource
class_name EventBackgroundDatabase
## Class for holding event backgrounds.

## The event backgrounds to be loaded into this database.
@export var background_resources: Array[EventBackground] = []

var _backgrounds: Dictionary = {}
var _combat_bg_queue: Array[EventBackground] = []


## Gets a background by its given key or null if no such background exists.
func get_background(key: String) -> EventBackground:
	return _backgrounds.get(key)


## Gets all backgrounds loaded into this database.
func get_backgrounds() -> Array:
	return _backgrounds.values()


## Loads this database.
func load() -> void:
	for res in background_resources:
		if _backgrounds.has(res.resource_name):
			print("Duplicate event background key '", res.resource_name, "'")
			continue
		
		print("Loading event background '", res.resource_name, "'")
		res.load()
		_backgrounds[res.resource_name] = res
		
		if res.is_event_allowed(GlobalEnums.EventTypeFlag.Mob):
			_combat_bg_queue.push_back(res)
	
	# Shuffle the combat backgrounds so the same one is not always first
	_combat_bg_queue.shuffle()


## Gets the next combat background in the queue for the given tree area.
func next_combat_bg(area: GlobalEnums.TreeAreaFlag) -> EventBackground:
	var bg: EventBackground = null
	var i: int = 0
	
	while bg == null and i < _combat_bg_queue.size():
		var curr_bg: EventBackground = _combat_bg_queue[i]
		
		if not curr_bg.is_area_allowed(area):
			i += 1
			continue
		
		_combat_bg_queue.pop_at(i)
		_combat_bg_queue.push_back(curr_bg)
		bg = curr_bg
	
	return bg
