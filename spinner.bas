#include once "list.bas"
#include once "functions/roll.bas"

type Spinner
 
 private:

 sides as List
 
 public:

 declare function Size() as Integer
 declare function Spin() as String
 
 declare sub AddSide(label as String)
 declare sub RemoveSide(label as String)
 
end type


function Spinner.Size() as Integer

 return sides.Length()

end function


function Spinner.Spin() as String

 return sides.ItemAt(RollDie(sides.Length()))

end function


sub Spinner.AddSide(label as String)

 sides.AddItem(label)
 
end sub


sub Spinner.RemoveSide(label as String)

 sides.RemoveItem(label)

end sub
