extends GutTest
## Test for EventBackgroundDatabase

var class_under_test: EventBackgroundDatabase = null

# @Override
func before_each() -> void:
	class_under_test = EventBackgroundDatabase.new()


# @Override
func after_each() -> void:
	assert_no_new_orphans("Orphans still exist, please free up test resources.")


func test_load_when_no_bg_resources_are_present_has_nbo_bgs() -> void:
	# Arrange
	const expected: int = 0
	
	# Act
	class_under_test.load()
	
	# Assert
	assert_eq(class_under_test.get_backgrounds().size(), expected)


func test_load_when_non_duplicate_bg_resources_are_present_has_expected_bgs() -> void:
	# Arrange
	const expected: int = 3
	var fake_bg_1: EventBackground = EventBackground.new()
	var fake_bg_2: EventBackground = EventBackground.new()
	var fake_bg_3: EventBackground = EventBackground.new()
	fake_bg_1.resource_name = "bg_1"
	fake_bg_2.resource_name = "bg_2"
	fake_bg_3.resource_name = "bg_3"
	class_under_test.background_resources = [
		fake_bg_1,
		fake_bg_2,
		fake_bg_3,
	]
	
	# Act
	class_under_test.load()
	
	# Assert
	assert_eq(class_under_test.get_backgrounds().size(), expected)


func test_load_when_duplicate_bg_resources_are_present_has_expected_bgs() -> void:
	# Arrange
	const expected: int = 1
	var fake_bg_1: EventBackground = EventBackground.new()
	var fake_bg_2: EventBackground = EventBackground.new()
	var fake_bg_3: EventBackground = EventBackground.new()
	fake_bg_1.resource_name = "bg"
	fake_bg_2.resource_name = "bg"
	fake_bg_3.resource_name = "bg"
	class_under_test.background_resources = [
		fake_bg_1,
		fake_bg_2,
		fake_bg_3,
	]
	
	# Act
	class_under_test.load()
	
	# Assert
	assert_eq(class_under_test.get_backgrounds().size(), expected)


func test_next_combat_bg_when_no_bgs_are_loaded_returns_null() -> void:
	# Arrange
	const tree_area: GlobalEnums.TreeAreaFlag = GlobalEnums.TreeAreaFlag.All
	class_under_test.load()
	
	# Act
	var actual: EventBackground = class_under_test.next_combat_bg(tree_area)
	
	# Assert
	assert_null(actual)


func test_next_combat_bg_when_bgs_are_loaded_and_are_not_in_area_returns_null() -> void:
	# Arrange
	const tree_area: GlobalEnums.TreeAreaFlag = GlobalEnums.TreeAreaFlag.RootsBeginning
	var fake_bg: EventBackground = _create_combat_bg()
	class_under_test.background_resources = [
		fake_bg,
	]
	class_under_test.load()
	
	# Assumptions
	assert_gt(class_under_test.get_backgrounds().size(), 0, "Assume backgrounds are loaded")
	
	# Act
	var actual: EventBackground = class_under_test.next_combat_bg(tree_area)
	
	# Assert
	assert_null(actual, "Assert that actual is null")


func test_next_combat_bg_when_bgs_are_loaded_and_are_in_area_returns_bg() -> void:
	# Arrange
	const tree_area: GlobalEnums.TreeAreaFlag = GlobalEnums.TreeAreaFlag.RootsBeginning
	var expected: EventBackground = _create_combat_bg()
	expected.allowed_areas = [
		tree_area,
	]
	class_under_test.background_resources = [
		expected,
	]
	class_under_test.load()
	
	# Assumptions
	assert_gt(class_under_test.get_backgrounds().size(), 0, "Assume backgrounds are loaded")
	
	# Act
	var actual: EventBackground = class_under_test.next_combat_bg(tree_area)
	
	# Assert
	assert_same(actual, expected, "Assert that actual is same as expected")


func test_next_combat_bg_when_called_multiple_times_returns_different_bg() -> void:
	# Arrange
	const tree_area: GlobalEnums.TreeAreaFlag = GlobalEnums.TreeAreaFlag.RootsBeginning
	var fake_bg_1: EventBackground = _create_combat_bg()
	var fake_bg_2: EventBackground = _create_combat_bg()
	fake_bg_1.resource_name = "bg_1"
	fake_bg_1.allowed_areas = [
		tree_area,
	]
	fake_bg_2.resource_name = "bg_2"
	fake_bg_2.allowed_areas = [
		tree_area,
	]
	class_under_test.background_resources = [
		fake_bg_1,
		fake_bg_2,
	]
	class_under_test.load()
	var bg: EventBackground = class_under_test.next_combat_bg(tree_area)
	
	# Assumptions
	assert_eq(class_under_test.get_backgrounds().size(), 2, "Assume backgrounds are loaded")
	assert_not_null(bg, "Assume first background was not null")
	
	# Act
	var actual: EventBackground = class_under_test.next_combat_bg(tree_area)
	
	# Assert
	assert_not_same(actual, bg, "Assert different background was returned")


func test_next_combat_bg_given_area_for_bg_at_end_of_queue_returns_expected() -> void:
	# Arrange
	const tree_area: GlobalEnums.TreeAreaFlag = GlobalEnums.TreeAreaFlag.RootsBeginning
	var expected: EventBackground = _create_combat_bg()
	var fake_bg: EventBackground = _create_combat_bg()
	expected.resource_name = "bg_1"
	expected.allowed_areas = [
		tree_area,
	]
	fake_bg.resource_name = "bg_2"
	class_under_test.background_resources = [
		fake_bg,
		expected,
	]
	class_under_test.load()
	
	# Assumptions
	assert_eq(class_under_test.get_backgrounds().size(), 2, "Assume backgrounds are loaded")
	
	# Act
	var actual: EventBackground = class_under_test.next_combat_bg(tree_area)
	
	# Assert
	assert_same(actual, expected, "Assert that actual is same as expected")


## Helper function used to create backgrounds for combat events
static func _create_combat_bg() -> EventBackground:
	var bg: EventBackground = EventBackground.new()
	bg.allowed_events = [
		GlobalEnums.EventTypeFlag.Mob,
	]
	
	return bg

