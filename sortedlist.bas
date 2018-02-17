#include once "list.bas"

type SortedList
 private:
  contents as List
 public:
  declare operator +=(rhs as SortedList)
  declare operator +=(rhs as List)
  declare operator +=(rhs as String)
  declare operator +=(rhs as Any ptr)
  declare operator +=(rhs as Long)
  declare function ContainsItem(item as String) as Boolean
  declare function ContainsPointer(item as Any ptr) as Boolean
  declare function ContainsValue(item as Long) as Boolean
  declare function FindIndex(item as String, segment as List) as Long 
  declare function IndexOfItem(item as String) as Long 
  declare function IndexOfPointer(item as Any ptr) as Long 
  declare function IndexOfValue(item as Long) as Long
  declare function Empty() as Boolean
  declare function ItemList() as List
  declare function ItemAt(index as Long) as String
  declare function NumberOfItem(item as String) as Long
  declare function NumberOfPointer(item as Any ptr) as Long
  declare function NumberOfValue(item as Long) as Long
  declare function PointerAt(index as Long) as Any ptr
  declare function Size() as Long
  declare function ValueAt(index as Long) as Long
  declare function Width() as Long
  declare sub AddList(items as List)
  declare sub AddItem(item as String)
  declare sub AddPointer(item as Any ptr)
  declare sub AddValue(item as Long)
  declare sub Destroy()
  declare sub RemoveIndex(index as Long)
  declare sub RemoveItem(item as String)
  declare sub RemovePointer(item as Any ptr)
  declare sub RemoveValue(item as Long)
end type

operator SortedList.+=(rhs as SortedList)
 AddList(rhs.contents)
end operator

operator SortedList.+=(rhs as List)
 AddList(rhs)
end operator

operator SortedList.+=(rhs as String)
 AddItem(rhs)
end operator

operator SortedList.+=(rhs as Any ptr)
 AddPointer(rhs)
end operator

operator SortedList.+=(rhs as Long)
 AddValue(rhs)
end operator

function SortedList.ContainsItem(item as String) as Boolean
 return IndexOfItem(item) > 0
end function

function SortedList.ContainsPointer(item as Any ptr) as Boolean
 return IndexOfPointer(item) > 0
end function

function SortedList.ContainsValue(item as Long) as Boolean
 return IndexOfValue(item) > 0
end function

function SortedList.FindIndex(item as String, segment as List) as Long
 dim result as Long
 result = (segment.Size() + 1) \ 2
 if segment.Size() > 1 then
  if item < segment.ItemAt(result) then
   result = FindIndex(item, segment.Slice(1, result))
  elseif item > segment.ItemAt(result) then
   result += FindIndex(item, segment.Slice(result + 1, segment.Size()))
  end if
 else
  if item > segment.ItemAt(result) then
   result += 1
  end if
 end if
 return result
end function

function SortedList.IndexOfItem(item as String) as Long
 dim result as Long
 result = FindIndex(item, contents)
 if contents.ItemAt(result) <> item then result = 0
 return result
end function

function SortedList.IndexOfPointer(item as Any ptr) as Long
 return IndexOfItem(PointerToString(item))
end function

function SortedList.IndexOfValue(item as Long) as Long
 return IndexOfItem(str(item))
end function

function SortedList.Empty() as Boolean
 return contents.Empty()
end function

function SortedList.ItemAt(index as Long) as String
 return contents.ItemAt(index)
end function

function SortedList.ItemList() as List
 return contents
end function

function SortedList.Size() as Long
 return contents.Size()
end function

function SortedList.NumberOfItem(item as String) as Long
 dim result as Long
 dim index as Long
 dim counter as Long
 index = IndexOfItem(item)
 if index > 0 then
  result = 1
  counter = 1
  do while contents.ItemAt(index + counter) = item
   result += 1
   counter += 1
  loop
  counter = 1
  do while contents.ItemAt(index - counter) = item
   result += 1
   counter += 1
  loop
 end if
 return result
end function

function SortedList.NumberOfPointer(item as Any ptr) as Long
 return NumberOfItem(PointerToString(item))
end function

function SortedList.NumberOfValue(item as Long) as Long
 return NumberOfItem(str(item))
end function

function SortedList.PointerAt(index as Long) as Any ptr
 return contents.PointerAt(index)
end function

function SortedList.ValueAt(index as Long) as Long
 return contents.ValueAt(index)
end function

function SortedList.Width() as Long
 return contents.Width()
end function

sub SortedList.AddList(items as List)
 for i as Long = 1 to items.Size()
  AddItem(items.ItemAt(i))
 next
end sub

sub SortedList.AddItem(item as String)
 dim index as Long
 if contents.Empty() then
  contents.AddItem(item)
 else
  index = FindIndex(item, contents)
  if index <= contents.Size() then
   contents.InsertItem(index, item)
  else
   contents.AddItem(item)
  end if
 end if
end sub

sub SortedList.AddPointer(item as Any ptr)
 AddItem(PointerToString(item))
end sub

sub SortedList.AddValue(item as Long)
 AddItem(str(item))
end sub

sub SortedList.Destroy()
 contents.Destroy()
end sub

sub SortedList.RemoveIndex(index as Long)
 contents.RemoveIndex(index)
end sub

sub SortedList.RemoveItem(item as String)
 contents.RemoveItem(item)
end sub

sub SortedList.RemovePointer(item as Any ptr)
 contents.RemovePointer(item)
end sub

sub SortedList.RemoveValue(item as Long)
 contents.RemoveValue(item)
end sub
