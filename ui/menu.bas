#include "../list.bas"
#include "../keycodes.bas"
#include "../functions/minmax.bas"
#include "../functions/pad.bas"

type Menu

 private:
 
 options as List
 x as Integer
 y as Integer
 columns as Integer
 selected as Integer
 window_height as Integer
 window_top as Integer
 text_color as Byte
 highlight_color as Byte
 cancel as Boolean
 
 public:

 declare constructor(starting_x as Integer = 1, starting_y as Integer = 1, starting_columns as Integer = 1, starting_selected as Integer = 1, starting_window_height as Integer = 0, starting_window_top as Integer = 0)
 declare function Cancelled() as Boolean
 declare function HandleKey() as Boolean
 declare sub AddOption(new_option as String)
 declare sub Display()
 declare sub SetOptions(l as List)
 declare sub UserSelect()
 
end type


constructor Menu(starting_x as Integer = 1, starting_y as Integer = 1, starting_columns as Integer = 1, starting_selected as Integer = 1, starting_window_height as Integer = 0, starting_window_top as Integer = 0)

 x = starting_x
 y = starting_y
 columns = starting_columns
 selected = starting_selected
 window_height = starting_window_height
 window_top = starting_window_top
 text_color = 7
 highlight_color = 0
 cancel = false
 
end constructor


function Menu.Cancelled() as Boolean

 return cancel
 
end function


function Menu.HandleKey() as Boolean

 dim done as Boolean
 
 select case getkey
 case ESC_KEY
  cancel = true
  done = true
 case ENTER_KEY
  cancel = false
  done = true
 case UP_KEY
  if (selected - columns) >= 1 then selected -= columns
 case DOWN_KEY
  if (selected + columns) <= options.Length() then selected += columns
 case RIGHT_KEY
  if selected mod columns > 0 and selected < options.Length() then selected += 1
 case LEFT_KEY
  if selected mod columns <> 1 and columns > 1 and selected > 1 then selected -= 1
 case END_KEY
  selected = options.Length()
 case HOME_KEY
  selected = 1
 end select
 
 return done

end function


sub Menu.AddOption(new_option as String)

 options.AddItem(new_option)
 
end sub


sub Menu.Display()

 y = Max(y, 1)
 x = Max(x, 1)
 selected = Max(Min(selected, options.Length()), 1)

 locate y, x, 0
 for i as Integer = 1 to options.Length()
  if i = selected then
   color highlight_color, text_color
  else
   color text_color, highlight_color
  end if
  print Pad(options.ItemAt(i), options.Width() + 2);
  if i mod columns = 0 or i = options.Length() then print
 next
 color text_color, highlight_color
 
end sub


sub Menu.SetOptions(l as List)

 options = l

end sub


sub Menu.UserSelect()

 do
  Display()
 loop until HandleKey()
 
end sub

