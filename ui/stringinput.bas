#include once "../keycodes.bas"
#include once "../functions/minmax.bas"

type StringInput

 private:
 
 x as Integer
 y as Integer
 cancel as Boolean
 value as String
 max_length as Integer
 blank_char as String
 text_color as Byte
 highlight_color as Byte
 highlighted as Boolean
 
 public:
 
 declare constructor(starting_x as Integer = 1, starting_y as Integer = 1, starting_value as String = "", starting_max_length as Integer = 12, starting_blank as String = "_")
 declare function Cancelled() as Boolean
 declare function CurrentValue() as String
 declare function HandleKey(key as Long = 0) as Boolean
 declare sub ChangeLength(new_length as Integer)
 declare sub ChangeValue(new_value as String)
 declare sub Display()
 declare sub Highlight()
 declare sub UnHighlight()
 declare sub UserInput()

end type


constructor StringInput(starting_x as Integer = 1, starting_y as Integer = 1, starting_value as String = "", starting_max_length as Integer = 12, starting_blank as String = "_")

 x = starting_x
 y = starting_y
 cancel = false
 value = starting_value
 max_length = starting_max_length
 blank_char = starting_blank
 text_color = 7
 highlight_color = 0

end constructor


function StringInput.Cancelled() as Boolean

 return cancel

end function


function StringInput.CurrentValue() as String

 return value

end function


function StringInput.HandleKey(key as Long = 0) as Boolean

 dim done as Boolean
 
 if key = 0 then key = getkey
 select case key
 case ESC_KEY
  done = true
  cancel = true
 case ENTER_KEY
  done = true
  cancel = false
 case BACKSPACE_KEY
  if len(value) > 0 then value = left(value, len(value) - 1)
 case 32 to 126
  if len(value) < max_length then value += chr(key) 
 end select
 
 return done

end function


sub StringInput.ChangeLength(new_length as Integer)

 max_length = new_length
 value = left(value, Min(len(value), max_length))

end sub


sub StringInput.ChangeValue(new_value as String)

 value = left(new_value, Min(len(new_value), max_length))

end sub


sub StringInput.Display()

 if len(value) > max_length then value = left(value, max_length)
 locate y, x, 0
 if highlighted then
  color highlight_color, text_color
 else
  color text_color, highlight_color
 end if
 print value;
 print string(max_length - len(value), blank_char);

end sub


sub StringInput.Highlight()

 highlighted = true
 
end sub


sub StringInput.UnHighlight()

 highlighted = false
 
end sub


sub StringInput.UserInput()

 cancel = false
 do
  Display()
 loop until HandleKey()

end sub
