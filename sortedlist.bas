type SortedList

 contents as List

 function Contains(item as String) as Boolean
 function FindIndex(item as String, segment as List) as Integer
 function IndexOf(item as String) as Integer
 function IsEmpty() as Boolean
 function ItemList() as List
 function ItemAt(index as Integer) as String
 function Length() as Integer
 function NumberOf(item as String) as Integer
 function Width() as Integer
 sub AddAll(items as List)
 sub AddItem(item as String)
 sub Destroy()
 sub RemoveIndex(index as Integer)
 sub RemoveItem(item as String)
 sub Replace(item1 as String, item2 as String)

end type

function SortedList.Contains(item as String) as Boolean
 return (contents.ItemAt(IndexOf(item)) = item)
end function

function SortedList.FindIndex(item as String, segment as List) as Integer
 dim result as Integer
 result = (segment.Length() + 1) \ 2
 if item < segment.ItemAt(result) then
  result = FindIndex(key, segment.Slice(1, result))
 elseif item > segment.ItemAt(result) then
  result += FindIndex(key, segment.Slice(result + 1, segment.Length())
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
