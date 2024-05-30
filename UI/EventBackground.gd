extends Resource
class_name EventBackground
## A resource class for managing an event background and the contexes it may be used in.

## The texture for this background.
@export var texture: Texture2D

## The array containing the areas this background may be used for.
@export var allowed_areas: Array[GlobalEnums.TreeAreaFlag]

## The array containing the events this background may be used for.
@export var allowed_events: Array[GlobalEnums.EventTypeFlag]

var _allowed_areas: int = 0
var _allowed_events: int = 0

## Returns a boolean for whether the given area is allowed to use this background.
func is_area_allowed(area: GlobalEnums.TreeAreaFlag) -> bool:
	return _allowed_areas & area != 0


## Returns a boolean for whether the given event is allowed to use this background.
func is_event_allowed(event: GlobalEnums.EventTypeFlag) -> bool:
	return _allowed_events & event != 0


## Loads the properties for this background.[br]
## Ought to only be called once by the class that is managing this resource.
func load() -> void:
	for area in allowed_areas:
		_allowed_areas |= area
	
	for events in allowed_events:
		_allowed_events |= events
