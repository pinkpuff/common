#include once "../keycodes.bas"
#include once "../list.bas"
#include once "../functions/minmax.bas"
#include once "../functions/roundup.bas"

type Menu

 private:
 
 x as Integer
 y as Integer
 cancel as Boolean
 options as List
 columns as Integer
 selected as Integer
 window_height as Integer
 window_top as Integer
 text_color as Byte
 highlight_color as Byte
 
 public:

 declare constructor(starting_x as Integer = 1, starting_y as Integer = 1, starting_columns as Integer = 1, starting_selected as Integer = 1, starting_window_height as Integer = 0)
 declare function Cancelled() as Boolean
 declare function HandleKey(key as Long = 0) as Boolean
 declare function SelectedIndex() as Integer
 declare function SelectedItem() as String
 declare sub AddOption(new_option as String)
 declare sub ChangeOption(index as Integer = 0, new_option as String)
 declare sub Display()
 declare sub Erase()
 declare sub ResetOptions()
 declare sub SelectIndex(new_index as Integer)
 declare sub SelectItem(new_item as String)
 declare sub SetOptions(l as List)
 declare sub UserInput()
 
end type


constructor Menu(starting_x as Integer = 1, starting_y as Integer = 1, starting_columns as Integer = 1, starting_selected as Integer = 1, starting_window_height as Integer = 0)

 x = starting_x
 y = starting_y
 columns = Max(starting_columns, 1)
 selected = starting_selected
 window_height = starting_window_height
 window_top = 1
 text_color = 7
 highlight_color = 0
 cancel = false
 
end constructor


function Menu.Cancelled() as Boolean

 return cancel
 
end function


function Menu.HandleKey(key as Long = 0) as Boolean

 dim done as Boolean
 
 if key = 0 then key = getkey
 select case key
 case ESC_KEY
  cancel = true
  done = true
 case ENTER_KEY
  cancel = false
  done = true
 case UP_KEY
  if (selected - columns) >= 1 then
   selected -= columns
   if selected <= (window_top - 1) * columns then window_top -= 1
  end if
 case DOWN_KEY
  if (selected + columns) <= options.Length() then
   selected += columns
   if selected > (window_top + iif(window_height = 0, RoundUp(options.Length() / columns), window_height) - 1) * columns then
    window_top += 1
   end if
  end if
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


function Menu.SelectedIndex() as Integer

 return selected

end function


function Menu.SelectedItem() as String

 return options.ItemAt(selected)
 
end function


sub Menu.AddOption(new_option as String)

 options.AddItem(new_option)
 
end sub


sub Menu.ChangeOption(index as Integer = 0, new_option as String)

 if index = 0 then index = selected
 if index > 0 and index < options.Length() then
  options.AssignItem(index, new_option)
 end if

end sub


sub Menu.Display()

 dim lines as Integer
 dim index as Integer
 
 y = Max(y, 1)
 x = Max(x, 1)
 selected = Max(Min(selected, options.Length()), 1)
 lines = iif(window_height = 0, RoundUp(options.Length() / columns), window_height)
 
 locate ,, 0
 for i as Integer = 1 to lines
  for j as Integer = 1 to columns
   index = (window_top + i - 2) * columns + j
   if index = selected then
    color highlight_color, text_color
   else
    color text_color, highlight_color
   end if
   locate y + i - 1, x + (j - 1) * (options.Width() + 2)
   print options.ItemAt(index);
   color text_color, highlight_color
   print space(options.Width() - len(options.ItemAt(index)));
  next
 next
 locate y + lines, x
 
end sub


sub Menu.Erase()

 dim lines as Integer
 
 lines = iif(window_height = 0, RoundUp(options.Length() / columns), window_height)
 for i as Integer = 1 to lines
  locate y + i - 1, x
  print space(options.Width() * columns + 2 * (columns - 1));
 next

end sub


sub Menu.ResetOptions()

 options.Destroy()

end sub


sub Menu.SelectIndex(new_index as Integer)

 selected = Max(Min(new_index, options.Length()), 1)

end sub


sub Menu.SelectItem(new_item as String)

 dim result as Integer
 
 result = options.IndexOfItem(new_item)
 if result > 0 then selected = result

end sub


sub Menu.SetOptions(l as List)

 options = l

end sub


sub Menu.UserInput()

 cancel = false
 do
  Display()
 loop until HandleKey()
 
end sub

