#include once "dir.bi"
#include once "menu.bas"

type FileBrowser

 private:
 
 x as Integer
 y as Integer
 cancel as Boolean
 path as String
 m as Menu
 
 declare sub GenerateMenu()
 
 public:
 
 declare constructor(starting_x as Integer = 1, starting_y as Integer = 1, starting_path as String = "./", columns as Integer = 1, window_height as Integer = 0)
 declare function Cancelled() as Boolean
 declare function CurrentFile(include_path as Boolean = true) as String
 declare function CurrentPath() as String
 declare function HandleKey(key as Long = 0) as Boolean
 declare sub ChangePath(new_path as String)
 declare sub Display()
 declare sub UserInput()

end type


constructor FileBrowser(starting_x as Integer = 1, starting_y as Integer = 1, starting_path as String = "./", columns as Integer = 1, window_height as Integer = 0)

 x = starting_x
 y = starting_y
 cancel = false
 path = starting_path
 if path = "./" then path = curdir + "/"
 m = Menu(x, y, Max(columns, 1), 1, window_height)
 GenerateMenu()

end constructor


function FileBrowser.Cancelled() as Boolean

 return cancel
 
end function


function FileBrowser.CurrentFile(include_path as Boolean = true) as String

 return m.SelectedItem()
 
end function


function FileBrowser.CurrentPath() as String

 return path
 
end function


function FileBrowser.HandleKey(key as Long = 0) as Boolean

 dim done as Boolean
 dim dirs as List
 dim f as String
 dim attributes as Integer
 
 if key = 0 then key = getkey
 select case key
 case ENTER_KEY
  if m.SelectedItem() = ".." then
   m.Erase()
   path = left(path, instrrev(left(path, len(path) - 1), "/"))
   GenerateMenu()
  else
   f = Dir(path + "*", &hFF, attributes)
   do until f = ""
    if (attributes and fbDirectory) <> 0 then
     dirs.AddItem(f)
    end if
    f = Dir(attributes)
   loop
   if dirs.ContainsItem(m.SelectedItem()) then
    m.Erase()
    path = path + m.SelectedItem() + "/"
    GenerateMenu()
   else
    done = m.HandleKey(key)
    cancel = m.Cancelled()
   end if
  end if
 case else
  done = m.HandleKey(key)
  cancel = m.Cancelled()
 end select
 
 return done

end function


sub FileBrowser.ChangePath(new_path as String)

 path = new_path

end sub


sub FileBrowser.Display()

 m.Display()

end sub


sub FileBrowser.GenerateMenu()

 dim f as String
 
 m.ResetOptions()
 if path <> "/" then m.AddOption("..")
 f = Dir(path + "*", fbNormal or fbDirectory)
 do until f = ""
  m.AddOption(f)
  f = Dir()
 loop
 m.SelectIndex(1)

end sub


sub FileBrowser.UserInput()

 cancel = false
 do
  Display()
 loop until HandleKey()

end sub
