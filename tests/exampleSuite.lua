
module(..., package.seeall)

-- only once
function suite_setup()
  -- return false => suit won't run
end

function suite_teardown()

end

-- gets called befora EVERY test_ function
function setup()

end

-- after
function teardown()

end


function test_example()
  print("\n----- test runs -----\n")
end
