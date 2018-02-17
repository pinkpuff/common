#include once "functions/pointerstringconversion.bas"
#include once "functions/minmax.bas"

type List
 private:
  contents(any) as String 
 public:
  declare constructor()
  declare operator +=(rhs as List)
  declare operator +=(rhs as String)
  declare operator +=(rhs as Long)
  declare operator +=(rhs as Any ptr)
  declare operator -=(rhs as List)
  declare operator -=(rhs as String)
  declare operator -=(rhs as Long)
  declare operator -=(rhs as Any ptr)
  declare operator cast() as String
  declare function ContainsItem(item as String) as Boolean
  declare function ContainsPointer(item as Any ptr) as Boolean
  declare function ContainsValue(item as Long) as Boolean
  declare function Empty() as Boolean
  declare function IndexOfItem(item as String) as Long
  declare function IndexOfPointer(item as Any ptr) as Long
  declare function IndexOfValue(item as Long) as Long
  declare function ItemAt(index as Long) as String
  declare function PointerAt(index as Long) as Any ptr
  declare function Size() as Long
  declare function Slice(start as Long = 1, finish as Long = 0) as List
  declare function ValueAt(index as Long) as Long
  declare function Width() as Long
  declare sub AddItem(item as String)
  declare sub AddPointer(item as Any ptr)
  declare sub AddValue(item as Long)
  declare sub AssignItem(index as Long, item as String)
  declare sub AssignPointer(index as Long, item as Any ptr)
  declare sub AssignValue(index as Long, item as Long)
  declare sub Destroy()
  declare sub Fill(last_index as Long)
  declare sub FillWithItem(last_index as Long, item as String)
  declare sub FillWithPointer(last_index as Long, item as Any ptr)
  declare sub FillWithValue(last_index as Long, item as Long)
  declare sub InsertItem(index as Long, item as String)
  declare sub InsertPointer(index as Long, item as Any ptr)
  declare sub InsertValue(index as Long, item as Long)
  declare sub RemoveIndex(index as Long)
  declare sub RemoveItem(item as String)
  declare sub RemovePointer(item as Any ptr)
  declare sub RemoveValue(item as Long)
end type

declare operator +(lhs as List, rhs as List) as List
declare operator +(lhs as List, rhs as String) as List
declare operator +(lhs as List, rhs as Long) as List
declare operator +(lhs as List, rhs as Any ptr) as List
declare operator +(lhs as String, rhs as List) as List
declare operator +(lhs as Long, rhs as List) as List
declare operator +(lhs as Any ptr, rhs as List) as List
declare operator -(lhs as List, rhs as List) as List
declare operator -(lhs as List, rhs as String) as List
declare operator -(lhs as List, rhs as Long) as List
declare operator -(lhs as List, rhs as Any ptr) as List

operator +(lhs as List, rhs as List) as List
 dim result as List
 result += lhs
 result += rhs
 return result
end operator

operator +(lhs as List, rhs as String) as List
 dim result as List
 result += lhs
 result += rhs
 return result
end operator

operator +(lhs as List, rhs as Long) as List
 dim result as List
 result += lhs
 result += rhs
 return result
end operator

operator +(lhs as List, rhs as Any ptr) as List
 dim result as List
 result += lhs
 result += rhs
 return result
end operator

operator +(lhs as String, rhs as List) as List
 dim result as List
 result += lhs
 result += rhs
 return result
end operator

operator +(lhs as Long, rhs as List) as List
 dim result as List
 result += lhs
 result += rhs
 return result
end operator

operator +(lhs as Any ptr, rhs as List) as List
 dim result as List
 result += lhs
 result += rhs
 return result
end operator

operator -(lhs as List, rhs as List) as List
 dim result as List
 result += lhs
 result -= rhs
 return result
end operator

operator -(lhs as List, rhs as String) as List
 dim result as List
 result += lhs
 result -= rhs
 return result
end operator

operator -(lhs as List, rhs as Long) as List
 dim result as List
 result += lhs
 result -= rhs
 return result
end operator

operator -(lhs as List, rhs as Any ptr) as List
 dim result as List
 result += lhs
 result -= rhs
 return result
end operator

constructor List()
 redim contents(0)
end constructor

operator List.+=(rhs as List)
 for i as Long = 1 to rhs.Size()
  this += rhs.ItemAt(i)
 next
end operator

operator List.+=(rhs as String)
 redim preserve contents(Size() + 1)
 contents(Size()) = rhs
end operator

operator List.+=(rhs as Long)
 this += str(rhs)
end operator

operator List.+=(rhs as Any ptr)
 this += PointerToString(rhs)
end operator

operator List.-=(rhs as List)
 for i as Long = 1 to rhs.Size()
  this -= rhs.ItemAt(i)
 next
end operator

operator List.-=(rhs as String)
 do while ContainsItem(rhs)
  RemoveIndex(IndexOfItem(rhs))
 loop
end operator

operator List.-=(rhs as Any ptr)
 this -= PointerToString(rhs)
end operator

operator List.-=(rhs as Long)
 this -= str(rhs)
end operator

operator List.cast() as String
 dim result as String
 for i as Long = 1 to Size()
  result += contents(i)
  if i < Size() then result += ", "
 next
 return result
end operator

function List.ContainsItem(item as String) as Boolean
 return IndexOfItem(item) > 0
end function

function List.ContainsPointer(item as Any ptr) as Boolean
 return IndexOfPointer(item) > 0
end function

function List.ContainsValue(item as Long) as Boolean 
 return IndexOfValue(item) > 0
end function

function List.Empty() as Boolean
 return Size() = 0
end function

function List.IndexOfItem(item as String) as Long
 dim result as Long
 for i as Long = 1 to Size()
  if contents(i) = item then
   result = i
   exit for
  end if
 next
 return result
end function

function List.IndexOfPointer(item as Any ptr) as Long
 return IndexOfItem(PointerToString(item))
end function

function List.IndexOfValue(item as Long) as Long
 return IndexOfItem(str(item))
end function

function List.ItemAt(index as Long) as String
 return iif(index > Size() or index < 1, "", contents(index))
end function

function List.ValueAt(index as Long) as Long
 return iif(index > Size() or index < 1, 0, val(contents(index)))
end function

function List.PointerAt(index as Long) as Any ptr
 return iif(index > Size() or index < 1, 0, StringToPointer(contents(index)))
end function

function List.Size() as Long
 return ubound(contents)
end function 

function List.Slice(start as Long = 1, finish as Long = 0) as List
 dim result as List
 if finish = 0 then finish = Size()
 start = Max(1, start)
 finish = Min(finish, Size())
 for i as Long = start to finish
  result += contents(i)
 next
 return result
end function

function List.Width() as Long
 dim result as Long
 for i as Long = 1 to Size()
  result = Max(result, len(contents(i)))
 next
 return result
end function

sub List.AddItem(item as String)
 this += item
end sub

sub List.AddPointer(item as Any ptr)
 this += PointerToString(item)
end sub

sub List.AddValue(item as Long)
 this += str(item)
end sub

sub List.AssignItem(index as Long, item as String)
 if index <= Size() and index >= 1 then contents(index) = item
end sub

sub List.AssignPointer(index as Long, item as Any ptr)
 AssignItem(index, PointerToString(item))
end sub

sub List.AssignValue(index as Long, item as Long)
 AssignItem(index, str(item))
end sub

sub List.Destroy()
 redim contents(0)
end sub

sub List.Fill(last_index as Long)
 redim contents(last_index)
end sub

sub List.FillWithItem(last_index as Long, item as String)
 for i as Long = Size() + 1 to last_index
  this += item
 next
end sub

sub List.FillWithValue(last_index as Long, item as Long)
 FillWithItem(last_index, str(item))
end sub

sub List.FillWithPointer(last_index as Long, item as Any ptr)
 FillWithItem(last_index, PointerToString(item))
end sub

sub List.InsertItem(index as Long, item as String)
 if index <= Size() and index >= 1 then this = Slice(1, index - 1) + item + Slice(index)
end sub

sub List.InsertPointer(index as Long, item as Any ptr)
 InsertItem(index, PointerToString(item))
end sub

sub List.InsertValue(index as Long, item as Long)
 InsertItem(index, str(item))
end sub

sub List.RemoveIndex(index as Long)
 if index <= Size() and index >= 1 then this = Slice(1, index - 1) + Slice(index + 1)
end sub

sub List.RemoveItem(item as String)
 this -= item
end sub

sub List.RemovePointer(item as Any ptr)
 this -= item
end sub

sub List.RemoveValue(item as Long)
 this -= item
end sub
