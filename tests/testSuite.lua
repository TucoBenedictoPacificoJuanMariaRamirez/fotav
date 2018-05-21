
module(..., package.seeall)

local logic
local dummy_obj

-- only once
function suite_setup()
  -- return false => suit won't run
  logic = require("logic.logic")
  logic.createLevel(1)
  -- for faking pipe tap event on "p1"
  dummy_obj = {
    target = {
      id = 1
    }
  }
end

function suite_teardown()
end

-- gets called before EVERY test_ function
function setup()
  logic.tappable = true
  logic.tapCoolDown = false
end

-- after
function teardown()
end


function test_rating_of_0_on_start()
  logic.createLevel(1)
  assert_equal(0, logic.rating())
end

function test_rating_of_3_on_perfect_temps()
  logic.setCurrentTempOf("h1", logic.houses["h1"].goal)
  assert_equal(3, logic.rating())
end

function test_rating_returns_number()
  assert_number(logic.rating())
end

function test_temp_decrease_on_cooldown()
  initial = logic.getCurrentTempOf("h1")
  logic.simulateCooling()
  after = logic.getCurrentTempOf("h1")
  assert_true(after < initial)
end

function test_no_temp_increase_on_pipeTap_during_cooldown()
  logic.pipeTap(dummy_obj)
  initial = logic.getCurrentTempOf("h1")
  logic.pipeTap(dummy_obj)
  after = logic.getCurrentTempOf("h1")
  assert_equal(initial, after)
end

function test_temp_increase_on_pipeTap()
  initial = logic.getCurrentTempOf("h1")
  logic.pipeTap(dummy_obj)
  modified = logic.getCurrentTempOf("h1")
  assert_true(initial < modified)
end

function test_cooldown_set_after_pipeTap()
  logic.pipeTap(dummy_obj)
  assert_true(logic.tapCoolDown)
end
