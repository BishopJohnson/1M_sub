extends GutTest
## Test for EventBackground

var class_under_test: EventBackground = null

# @Override
func before_each() -> void:
	class_under_test = EventBackground.new()


# @Override
func after_each() -> void:
	assert_no_new_orphans("Orphans still exist, please free up test resources.")


func test_is_area_allowed_when_no_area_was_added_returns_false(
	params: Dictionary = use_parameters(ParameterFactory.named_parameters(
		['area'],
		[
			[
				GlobalEnums.TreeAreaFlag.None,
				GlobalEnums.TreeAreaFlag.RootsBeginning,
				GlobalEnums.TreeAreaFlag.RootsMiddle,
				GlobalEnums.TreeAreaFlag.RootsEnd,
				GlobalEnums.TreeAreaFlag.TrunkBeginning,
				GlobalEnums.TreeAreaFlag.TrunkMiddle,
				GlobalEnums.TreeAreaFlag.TrunkEnd,
				GlobalEnums.TreeAreaFlag.CanopyBeginning,
				GlobalEnums.TreeAreaFlag.CanopyMiddle,
				GlobalEnums.TreeAreaFlag.CanopyEnd,
			],
		])
	)
) -> void:
	# Arrange
	var area: GlobalEnums.TreeAreaFlag = params.area
	class_under_test.load()
	
	# Act
	var actual: bool = class_under_test.is_area_allowed(area)
	
	# Assert
	assert_false(actual)


func test_is_area_allowed_given_none_returns_false(
	params: Dictionary = use_parameters(ParameterFactory.named_parameters(
		['area'],
		[
			[
				GlobalEnums.TreeAreaFlag.None,
				GlobalEnums.TreeAreaFlag.RootsBeginning,
				GlobalEnums.TreeAreaFlag.RootsMiddle,
				GlobalEnums.TreeAreaFlag.RootsEnd,
				GlobalEnums.TreeAreaFlag.TrunkBeginning,
				GlobalEnums.TreeAreaFlag.TrunkMiddle,
				GlobalEnums.TreeAreaFlag.TrunkEnd,
				GlobalEnums.TreeAreaFlag.CanopyBeginning,
				GlobalEnums.TreeAreaFlag.CanopyMiddle,
				GlobalEnums.TreeAreaFlag.CanopyEnd,
			],
		])
	)
) -> void:
	# Arrange
	var area: GlobalEnums.TreeAreaFlag = GlobalEnums.TreeAreaFlag.None
	class_under_test.allowed_areas = [
		params.area,
	]
	class_under_test.load()
	
	# Act
	var actual: bool = class_under_test.is_area_allowed(area)
	
	# Assert
	assert_false(actual)


func test_is_area_allowed_given_added_area_returns_true(
	params: Dictionary = use_parameters(ParameterFactory.named_parameters(
		['area'],
		[
			[
				GlobalEnums.TreeAreaFlag.RootsBeginning,
				GlobalEnums.TreeAreaFlag.RootsMiddle,
				GlobalEnums.TreeAreaFlag.RootsEnd,
				GlobalEnums.TreeAreaFlag.TrunkBeginning,
				GlobalEnums.TreeAreaFlag.TrunkMiddle,
				GlobalEnums.TreeAreaFlag.TrunkEnd,
				GlobalEnums.TreeAreaFlag.CanopyBeginning,
				GlobalEnums.TreeAreaFlag.CanopyMiddle,
				GlobalEnums.TreeAreaFlag.CanopyEnd,
			],
		])
	)
) -> void:
	# Arrange
	var area: GlobalEnums.TreeAreaFlag = params.area
	class_under_test.allowed_areas = [
		area,
	]
	class_under_test.load()
	
	# Act
	var actual: bool = class_under_test.is_area_allowed(area)
	
	# Assert
	assert_true(actual)


func test_is_event_allowed_when_no_event_was_added_returns_false(
	params: Dictionary = use_parameters(ParameterFactory.named_parameters(
		['event'],
		[
			[
				GlobalEnums.EventTypeFlag.None,
				GlobalEnums.EventTypeFlag.Dialogue,
				GlobalEnums.EventTypeFlag.Heal,
				GlobalEnums.EventTypeFlag.Mob,
				GlobalEnums.EventTypeFlag.Shop,
			],
		])
	)
) -> void:
	# Arrange
	var event: GlobalEnums.EventTypeFlag = params.event
	class_under_test.load()
	
	# Act
	var actual: bool = class_under_test.is_event_allowed(event)
	
	# Assert
	assert_false(actual)


func test_is_event_allowed_given_none_returns_false(
	params: Dictionary = use_parameters(ParameterFactory.named_parameters(
		['event'],
		[
			[
				GlobalEnums.EventTypeFlag.None,
				GlobalEnums.EventTypeFlag.Dialogue,
				GlobalEnums.EventTypeFlag.Heal,
				GlobalEnums.EventTypeFlag.Mob,
				GlobalEnums.EventTypeFlag.Shop,
			],
		])
	)
) -> void:
	# Arrange
	var event: GlobalEnums.EventTypeFlag = GlobalEnums.EventTypeFlag.None
	class_under_test.allowed_events = [
		params.event,
	]
	class_under_test.load()
	
	# Act
	var actual: bool = class_under_test.is_event_allowed(event)
	
	# Assert
	assert_false(actual)


func test_is_event_allowed_given_added_event_returns_true(
	params: Dictionary = use_parameters(ParameterFactory.named_parameters(
		['event'],
		[
			[
				GlobalEnums.EventTypeFlag.Dialogue,
				GlobalEnums.EventTypeFlag.Heal,
				GlobalEnums.EventTypeFlag.Mob,
				GlobalEnums.EventTypeFlag.Shop,
			],
		])
	)
) -> void:
	# Arrange
	var event: GlobalEnums.EventTypeFlag = params.event
	class_under_test.allowed_events = [
		event,
	]
	class_under_test.load()
	
	# Act
	var actual: bool = class_under_test.is_event_allowed(event)
	
	# Assert
	assert_true(actual)

