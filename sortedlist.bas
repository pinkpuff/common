#include once "list.bas"

type SortedList

 private:
 contents as List

 public:
 declare function Contains(item as String) as Boolean
 declare function FindIndex(item as String, segment as List) as Integer
 declare function IndexOf(item as String) as Integer
 declare function IsEmpty() as Boolean
 declare function ItemList() as List
 declare function ItemAt(index as Integer) as String
 declare function Length() as Integer
 declare function NumberOf(item as String) as Integer
 declare function Width() as Integer

 declare sub AddAll(items as List)
 declare sub AddItem(item as String)
 declare sub Destroy()
 declare sub RemoveIndex(index as Integer)
 declare sub RemoveItem(item as String)
 declare sub Replace(item1 as String, item2 as String)

end type


function SortedList.Contains(item as String) as Boolean

 return (contents.ItemAt(IndexOf(item)) = item)

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


function SortedList.IndexOf(item as String) as Integer

 dim result as Integer

 result = FindIndex(item, contents)
 if contents.ItemAt(result) <> item then result = 0

 return result

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


function SortedList.NumberOf(item as String) as Integer

 dim result as Integer
 dim index as Integer
 dim counter as Integer

 index = IndexOf(item)
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


function SortedList.Width() as Integer

 return contents.Width()

end function


sub SortedList.AddAll(items as List)

 for i as Integer = 1 to items.Length()
  AddItem(items.ItemAt(i))
 next

end sub


sub SortedList.AddItem(item as String)

 if contents.IsEmpty() then
  contents.Append(item)
 else
  contents.Insert(FindIndex(item, contents), item)
 end if

end sub


sub SortedList.Destroy()

 contents.Destroy()

end sub


sub SortedList.RemoveIndex(index as Integer)

 contents.Remove(index)

end sub


sub SortedList.RemoveItem(item as String)

 do while Contains(item)
  contents.Remove(IndexOf(item))
 loop

end sub


sub SortedList.Replace(item1 as String, item2 as String)

 dim total as Integer

 total = NumberOf(item1)
 for i as Integer = 1 to total
  RemoveItem(item1)
  AddItem(item2)
 next

end sub
