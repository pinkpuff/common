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

 sides.Append(label)
 
end sub


sub Spinner.RemoveSide(label as String)

 dim temp as List
 
 for i as Integer = 1 to sides.Length()
  if sides.ItemAt(i) <> label then temp.Append(sides.ItemAt(i))
 next
 
 sides = temp

end sub
