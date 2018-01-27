#include once "list.bas"

type SortedList

 private:
 contents as List

 public:
 declare function ContainsItem(item as String) as Boolean
 declare function ContainsPointer(item as Any ptr) as Boolean
 declare function ContainsValue(item as Integer) as Boolean
 declare function FindIndex(item as String, segment as List) as Integer
 declare function IndexOfItem(item as String) as Integer
 declare function IndexOfPointer(item as Any ptr) as Integer
 declare function IndexOfValue(item as Integer) as Integer
 declare function IsEmpty() as Boolean
 declare function ItemList() as List
 declare function ItemAt(index as Integer) as String
 declare function Length() as Integer
 declare function NumberOfItem(item as String) as Integer
 declare function NumberOfPointer(item as Any ptr) as Integer
 declare function NumberOfValue(item as Integer) as Integer
 declare function PointerAt(index as Integer) as Any ptr
 declare function ValueAt(index as Integer) as Integer
 declare function Width() as Integer

 declare sub AddAll(items as List)
 declare sub AddItem(item as String)
 declare sub AddPointer(item as Any ptr)
 declare sub AddValue(item as Integer)
 declare sub Destroy()
 declare sub RemoveIndex(index as Integer)
 declare sub RemoveItem(item as String)
 declare sub RemovePointer(item as Any ptr)
 declare sub RemoveValue(item as Integer)

end type


function SortedList.ContainsItem(item as String) as Boolean

 return IndexOfItem(item) > 0

end function


function SortedList.ContainsPointer(item as Any ptr) as Boolean

 return IndexOfPointer(item) > 0

end function


function SortedList.ContainsValue(item as Integer) as Boolean

 return IndexOfValue(item) > 0

end function


function SortedList.FindIndex(item as String, segment as List) as Integer

 dim result as Integer

 result = (segment.Length() + 1) \ 2
 if segment.Length() > 1 then
  if item < segment.ItemAt(result) then
   result = FindIndex(item, segment.Slice(1, result))
  elseif item > segment.ItemAt(result) then
   result += FindIndex(item, segment.Slice(result + 1, segment.Length()))
  end if
 else
  if item > segment.ItemAt(result) then
   result += 1
  end if
 end if

 return result

end function


function SortedList.IndexOfItem(item as String) as Integer

 dim result as Integer

 result = FindIndex(item, contents)
 if contents.ItemAt(result) <> item then result = 0

 return result

end function


function SortedList.IndexOfPointer(item as Any ptr) as Integer

 return IndexOfItem(PointerToString(item))

end function


function SortedList.IndexOfValue(item as Integer) as Integer

 return IndexOfItem(str(item))

end function


function SortedList.IsEmpty() as Boolean

 return contents.IsEmpty()

end function


function SortedList.ItemAt(index as Integer) as String

 return contents.ItemAt(index)

end function


function SortedList.ItemList() as List

 return contents
 
end function


function SortedList.Length() as Integer

 return contents.Length()

end function


function SortedList.NumberOfItem(item as String) as Integer

 dim result as Integer
 dim index as Integer
 dim counter as Integer

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


function SortedList.NumberOfPointer(item as Any ptr) as Integer

 return NumberOfItem(PointerToString(item))

end function


function SortedList.NumberOfValue(item as Integer) as Integer

 return NumberOfItem(str(item))

end function


function SortedList.PointerAt(index as Integer) as Any ptr

 return contents.PointerAt(index)

end function


function SortedList.ValueAt(index as Integer) as Integer

 return contents.ValueAt(index)

end function


function SortedList.Width() as Integer

 return contents.Width()

end function


sub SortedList.AddAll(items as List)

 for i as Integer = 1 to items.Length()
  AddItem(items.ItemAt(i))
 next

end sub


sub SortedList.AddItem(item as String)

 dim index as Integer
 
 if contents.IsEmpty() then
  contents.AddItem(item)
 else
  index = FindIndex(item, contents)
  if index <= contents.Length() then
   contents.InsertItem(index, item)
  else
   contents.AddItem(item)
  end if
 end if

end sub


sub SortedList.AddPointer(item as Any ptr)

 AddItem(PointerToString(item))

end sub


sub SortedList.AddValue(item as Integer)

 AddItem(str(item))

end sub


sub SortedList.Destroy()

 contents.Destroy()

end sub


sub SortedList.RemoveIndex(index as Integer)

 contents.RemoveIndex(index)

end sub


sub SortedList.RemoveItem(item as String)

 contents.RemoveItem(item)

end sub


sub SortedList.RemovePointer(item as Any ptr)

 contents.RemovePointer(item)

end sub


sub SortedList.RemoveValue(item as Integer)

 contents.RemoveValue(item)

end sub
