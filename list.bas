'When storing pointers in the list, removing or replacing a pointer will
' deallocate the pointer you removed or replaced.

#include once "functions\pointerstringconversion.bas"

type List

 private:
 
 contents as String ptr
 items as Integer
 
 public:
 
 declare function ContainsItem(item as String) as Boolean
 declare function ContainsPointer(item as Any ptr) as Boolean
 declare function ContainsValue(item as Integer) as Boolean
 declare function IndexOfItem(item as String) as Integer
 declare function IndexOfPointer(item as Any ptr) as Integer
 declare function IndexOfValue(item as Integer) as Integer
 declare function IsEmpty() as Boolean
 declare function ItemAt(index as Integer) as String
 declare function Length() as Integer
 declare function PointerAt(index as Integer) as Any ptr
 declare function Slice(start as Integer = 1, finish as Integer = 0) as List
 declare function ValueAt(index as Integer) as Integer
 declare function Width() as Integer

 declare sub AddItem(item as String)
 declare sub AddPointer(item as Any ptr)
 declare sub AddValue(item as Integer)
 declare sub AssignItem(index as Integer, item as String)
 declare sub AssignPointer(index as Integer, item as Any ptr)
 declare sub AssignValue(index as Integer, item as Integer)
 declare sub Destroy()
 declare sub Exchange(index1 as Integer, index2 as Integer)
 declare sub InsertItem(index as Integer, item as String)
 declare sub InsertPointer(index as Integer, item as Any ptr)
 declare sub InsertValue(index as Integer, item as Integer)
 declare sub Join(l as List)
 declare sub PrependItem(item as String)
 declare sub PrependPointer(item as Any ptr)
 declare sub PrependValue(item as Integer)
 declare sub RemoveIndex(index as Integer)
 declare sub RemoveItem(item as String)
 declare sub RemovePointer(item as Any ptr)
 declare sub RemoveValue(item as Integer)

end type


function List.ContainsItem(item as String) as Boolean

 return IndexOfItem(item) > 0

end function


function List.ContainsPointer(item as Any ptr) as Boolean

 return ContainsItem(PointerToString(item))

end function


function List.ContainsValue(item as Integer) as Boolean

 return ContainsItem(str(item))

end function


function List.IndexOfItem(item as String) as Integer

 dim result as Integer
 
 for i as Integer = 1 to Length()
  if ItemAt(i) = item then
   result = i
   exit for
  end if
 next
 
 return result

end function


function List.IndexOfPointer(item as Any ptr) as Integer

 return IndexOfItem(PointerToString(item))

end function


function List.IndexOfValue(item as Integer) as Integer

 return IndexOfItem(str(item))

end function


function List.IsEmpty() as Boolean

 return (items = 0)
 
end function


function List.ItemAt(index as Integer) as String

 dim result as String = ""
 
 if index > 0 and index <= items then result = contents[index - 1]
 
 return result

end function


function List.Length() as Integer

 return items

end function


function List.PointerAt(index as Integer) as Any ptr

 dim result as Any ptr

 if index > 0 and index <= Length() then result = StringToPointer(ItemAt(index))

 return result

end function


function List.Slice(start as Integer = 1, finish as Integer = 0) as List

 dim result as List
 
 if items > 0 then
  if finish = 0 then finish = items
  if start > finish then swap start, finish
  if start <= items then
   if finish > items then finish = items
   for i as Integer = start to finish
    result.AddItem(ItemAt(i))
   next
  end if
 end if
 
 return result

end function


function List.ValueAt(index as Integer) as Integer

 return val(ItemAt(index))

end function


function List.Width() as Integer

 dim result as Integer
 dim temp as Integer
 
 for i as Integer = 1 to items
  temp = len(ItemAt(i))
  if temp > result then result = temp
 next
 
 return result

end function


sub List.AddItem(item as String)

 if items > 0 then
  items += 1
  contents = reallocate(contents, items * SizeOf(String))
  clear contents[items - 1], 0, SizeOf(String)
  contents[items - 1] = item
 else
  contents = callocate(SizeOf(String))
  contents[0] = item
  items = 1
 end if

end sub


sub List.AddPointer(item as Any ptr)

 AddItem(PointerToString(item))

end sub


sub List.AddValue(item as Integer)

 AddItem(str(item))

end sub


sub List.AssignItem(index as Integer, item as String)

 if index > 0 then
  if index > items then
   for i as Integer = items + 1 to index - 1
    AddItem("")
   next
   AddItem(item)
  else
   contents[index - 1] = item
  end if
 end if

end sub


sub List.AssignPointer(index as Integer, item as Any ptr)
 
 dim p as Any ptr
 
 p = PointerAt(index)
 if p <> 0 and p <> item then deallocate(p)
 AssignItem(index, PointerToString(item))

end sub


sub List.AssignValue(index as Integer, item as Integer)

 AssignItem(index, str(item))

end sub


sub List.Destroy()

 if items > 0 then
  for i as Integer = 1 to items - 1
   contents[i] = ""
  next
  deallocate(contents)
  contents = 0
  items = 0
 end if
 
end sub


sub List.Exchange(index1 as Integer, index2 as Integer)

 if index1 > 0 and index1 <= items and index2 > 0 and index2 <= items then
  swap contents[index1 - 1], contents[index2 - 1]
 end if

end sub


sub List.InsertItem(index as Integer, item as String)

 if index > 0 and index <= items then
  AddItem(ItemAt(items))
  for i as Integer = items - 1 to index + 1 step - 1
   AssignItem(i, ItemAt(i - 1))
  next
  AssignItem(index, item)
 end if

end sub


sub List.InsertPointer(index as Integer, item as Any ptr)

 InsertItem(index, PointerToString(item))

end sub


sub List.InsertValue(index as Integer, item as Integer)

 InsertItem(index, str(item))

end sub


sub List.Join(l as List)

 for i as Integer = 1 to l.Length()
  AddItem(l.ItemAt(i))
 next

end sub


sub List.PrependItem(item as String)

 InsertItem(1, item)

end sub


sub List.PrependPointer(item as Any ptr)

 InsertPointer(1, item)
 
end sub


sub List.PrependValue(item as Integer)

 InsertValue(1, item)

end sub


sub List.RemoveIndex(index as Integer)

 if items > 0 and index <= items then
  items -= 1
  contents[index - 1] = ""
  for i as Integer = index - 1 to items - 1
   contents[i] = contents[i + 1]
  next
  contents = reallocate(contents, items * SizeOf(String))
 end if
 
end sub


sub List.RemoveItem(item as String)

 dim index as Integer = 1

 do while index <= Length()
  if ItemAt(index) = item then
   RemoveIndex(index)
  else
   index += 1
  end if
 loop

end sub


sub List.RemovePointer(item as Any ptr)

 dim index as Integer = 1

 do while index <= Length()
  if PointerAt(index) = item then
   RemoveIndex(index)
  else
   index += 1
  end if
 loop
 deallocate(item)

end sub


sub List.RemoveValue(item as Integer)

 dim index as Integer = 1

 do while index <= Length()
  if ValueAt(index) = item then
   RemoveIndex(index)
  else
   index += 1
  end if
 loop

end sub
