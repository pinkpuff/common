#include once "list.bas"
#include once "functions/roll.bas"

type Spinner
 private:
  sides as List
 public:
  declare operator +=(rhs as List)
  declare operator +=(rhs as String)
  declare operator -=(rhs as String)
  declare function Size() as Integer
  declare function Spin() as String
  declare sub AddSide(label as String)
  declare sub RemoveSide(label as String)
end type

operator Spinner.+=(rhs as List)
 for i as Long = 1 to rhs.Size()
  AddSide(rhs.ItemAt(i))
 next
end operator

operator Spinner.+=(rhs as String)
 AddSide(rhs)
end operator

operator Spinner.-=(rhs as String)
 RemoveSide(rhs)
end operator

function Spinner.Size() as Integer
 return sides.Size()
end function

function Spinner.Spin() as String
 return sides.ItemAt(RollDie(sides.Size()))
end function

sub Spinner.AddSide(label as String)
 sides += label
end sub

sub Spinner.RemoveSide(label as String)
 sides -= label
end sub
