#include once "../keycodes.bas"
#include once "../functions/pad.bas"
#include once "../functions/minmax.bas"

type NumberInput
 private:
  x as Integer
  y as Integer
  cancel as Boolean
  value as Integer
  min_value as Integer
  max_value as Integer
  text_color as Byte
  highlight_color as Byte
  highlighted as Boolean
 public:
  declare constructor(starting_x as Integer = 1, starting_y as Integer = 1, starting_value as Integer = 1, starting_min_value as Integer = 0, starting_max_value as Integer = 255)
  declare function Cancelled() as Boolean
  declare function CurrentValue() as Integer
  declare function HandleKey(key as Long = 0) as Boolean
  declare sub ChangeMax(new_max as Integer)
  declare sub ChangeMin(new_min as Integer)
  declare sub ChangeValue(new_value as Integer)
  declare sub Display()
  declare sub Highlight()
  declare sub UnHighlight()
  declare sub UserInput()
end type

constructor NumberInput(starting_x as Integer = 1, starting_y as Integer = 1, starting_value as Integer = 1, starting_min_value as Integer = 0, starting_max_value as Integer = 255)
 x = starting_x
 y = starting_y
 value = starting_value
 min_value = starting_min_value
 max_value = starting_max_value
 text_color = 7
 highlight_color = 0
 highlighted = false
end constructor

function NumberInput.Cancelled() as Boolean
 return cancel
end function

function NumberInput.CurrentValue() as Integer
 return value
end function

function NumberInput.HandleKey(key as Long = 0) as Boolean
 dim done as Boolean
 value = Max(min_value, Min(max_value, value)) 
 if key = 0 then key = getkey
 select case key
 case ESC_KEY
  done = true
  cancel = true
 case ENTER_KEY
  done = true
  cancel = false
 case UP_KEY
  if value < max_value then value += 1
 case DOWN_KEY
  if value > min_value then value -= 1
 case HOME_KEY
  value = min_value
 case END_KEY
  value = max_value
 case PAGEUP_KEY
  value = Min(max_value, value + 10)
 case PAGEDOWN_KEY
  value = Max(min_value, value - 10)
 case asc("0") to asc("9")
  if value * 10 + (key - 48) <= max_value then value = value * 10 + (key - 48)
 case BACKSPACE_KEY
  value = Max(min_value, value \ 10)
 end select
 return done
end function

sub NumberInput.ChangeMax(new_max as Integer)
 max_value = new_max
 value = Min(value, max_value)
end sub

sub NumberInput.ChangeMin(new_min as Integer)
 min_value = new_min
 value = Max(value, min_value)
end sub

sub NumberInput.ChangeValue(new_value as Integer)
 value = Min(max_value, Max(min_value, new_value))
end sub

sub NumberInput.Display()
 if highlighted then
  color highlight_color, text_color
 else
  color text_color, highlight_color
 end if
 locate y, x, 0
 print Pad(str(value), len(str(max_value)), true);
end sub

sub NumberInput.Highlight()
 highlighted = true
end sub

sub NumberInput.UnHighlight()
 highlighted = false
end sub

sub NumberInput.UserInput()
 cancel = false
 do
  Display()
 loop until HandleKey()
end sub
