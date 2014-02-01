local common = require 'common'
local Button = require 'button'

local Window = {}
local metatable = common.create_metatable(Window)

function metatable.set_title(window, value)
  if type(value) ~= 'string' and type(value) ~= 'number' then
    local message = string.format('The title of a window must be a string, not a %s.', type(value))
    error(message, 3)
  end
  
  window.wx_frame:SetLabel(tostring(value))
end

function metatable.set_width(window, value)
  if type(value) ~= 'number' then
    local message = string.format('The width of a window must be a number, not a %s.', type(value))
    error(message, 3)
  end
  
  local height = window.height or window.wx_frame:GetClientSize():GetHeight()
  window.wx_frame:SetClientSize(value, height)
  
  return window.wx_frame:GetClientSize():GetWidth()
end

function metatable.set_height(window, value)
  if type(value) ~= 'number' then
    local message = string.format('The height of a window must be a number, not a %s.', type(value))
    error(message, 3)
  end
  
  local width = window.width or window.wx_frame:GetClientSize():GetWidth()
  window.wx_frame:SetClientSize(width, value)
  
  return window.wx_frame:GetClientSize():GetHeight()
end

function Window.create()
  local window = {}
  
  window.wx_frame = wx.wxFrame(
    wx.NULL,
    wx.wxID_ANY,
    '',
    wx.wxDefaultPosition,
    wx.wxSize(640, 480),
    wx.wxDEFAULT_FRAME_STYLE)
  
  window.wx_panel = wx.wxPanel(
    window.wx_frame,
    wx.wxID_ANY,
    wx.wxDefaultPosition,
    wx.wxDefaultSize)
  
  window.wx_frame:Show(true)
  
  setmetatable(window, metatable);
  metatable[window] = {}
  
  window.title = ''
  window.width = 640
  window.height = 480
  
  return window
end

function Window:add_button()
  return Button.create(self.wx_panel)
end

return Window