local unit_test = require 'test.unit_test'
local assert = unit_test.assert

require 'gui'

local window, button

local suite = {
  set_up = function()
    window = gui.create_window()
    button = window:add_button()
  end,
  
  ['a button has a size'] = function()
    button.width = 50
    button.height = 25
    
    assert.equal(50, button.width)
    assert.equal(25, button.height)
  end,
  
  ['a button has a position'] = function()
    button.x = 95
    button.y = 66
    
    assert.equal(95, button.x)
    assert.equal(66, button.y)
  end,
  
  ['a button has text'] = function()
    button.text = 'click me'
    
    assert.equal('click me', button.text)
  end,
  
  ['a button raises a click event'] = function()
    local handler_called = false
    button.on_click = function()
      handler_called = true
    end
    
    button:click()
    
    assert.is_true(handler_called)
  end,
  
  ['a button can be anchored'] = function()
    window.width = 200
    window.height = 200
    
    button.x = 50
    button.y = 50
    button.width = 100
    button.height = 100
    button.anchor = 'all'
    
    window.width = 500
    window.height = 300
    
    assert.equal(400, button.width)
    assert.equal(200, button.height)
  end
}

unit_test.run(suite)