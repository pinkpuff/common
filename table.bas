#include once "list.bas"

type Table

 contents as List

 declare function Column(x as Integer) as List
 declare function Height() as Integer
 declare function ItemAt(x as Integer, y as Integer) as String
 declare function PointerAt(x as Integer, y as Integer) as Any ptr
 declare function ValueAt(x as Integer, y as Integer) as Integer
 declare function Row(y as Integer) as List
 declare function SubTable(x1 as Integer, y1 as Integer, x2 as Integer, y2 as Integer) as Table
 declare function Width() as Integer

 declare sub Assign overload (x as Integer, y as Integer, item as String)
 declare sub Assign overload (x as Integer, y as Integer, item as Any ptr)
 declare sub Destroy()
 declare sub Remove(x as Integer, y as Integer)

end type


function Table.Column(x as Integer) as List

 dim result as List
 dim l as List ptr

 for i as Integer = 1 to Height()
  l = contents.PointerAt(i)
  result.AddItem(l->ItemAt(x))
 next

 return result

end function


function Table.Height() as Integer

 return contents.Length()

end function


function Table.ItemAt(x as Integer, y as Integer) as String

 dim l as List ptr

 l = contents.PointerAt(y)

 return l->ItemAt(x)

end function


function Table.PointerAt(x as Integer, y as Integer) as Any ptr

 dim l as List ptr

 l = contents.PointerAt(y)

 return l->PointerAt(x)

end function


function Table.ValueAt(x as Integer, y as Integer) as Integer

 dim l as List ptr
 
 l = contents.PointerAt(y)
 
 return l->ValueAt(x)

end function


function Table.Row(y as Integer) as List

 dim l as List ptr

 l = contents.PointerAt(y)

 return *l

end function


function Table.SubTable(x1 as Integer, y1 as Integer, x2 as Integer, y2 as Integer) as Table

 dim t as Table
 dim l as List ptr
 dim temp as List ptr

 for i as Integer = y1 to y2
  l = contents.PointerAt(i)
  temp = callocate(len(List))
  *temp = l->Slice(x1, x2)
  t.contents.Append(temp)
 next

 return t

end function


function Table.Width() as Integer

 dim result as Integer
 dim l as List ptr
 
 if contents.Length() = 0 then
  result = 0
 else
  l = contents.PointerAt(1)
  result = l->Length()
 end if

 return result

end function


sub Table.AssignItem(x as Integer, y as Integer, item as String)

 dim l as List ptr

 if y > Height() then
  for i as Integer = Height() + 1 to y
   l = callocate(SizeOf(List))
   l->Assign(Width(), "")
   contents.Append(l)
  next
 end if

 if x > Width() then
  for i as Integer = 1 to Height()
   l = contents.PointerAt(i)
   l->Assign(x, "")
  next
 end if

 l = contents.PointerAt(y)
 l->Assign(x, item)

end sub


sub Table.AssignPointer(x as Integer, y as Integer, item as Any ptr)

 Assign(x, y, PointerToString(item))

end sub


sub Table.AssignValue(x as Integer, y as Integer, item as Integer)

 Assign(x, y, str(item))

end sub


sub Table.Destroy()

 dim l as List ptr

 for i as Integer = 1 to Height()
  l = contents.PointerAt(i)
  l->Destroy()
 next

 contents.Destroy()

end sub


sub Table.Remove(x as Integer, y as Integer)

 dim l as List ptr

 l = contents.PointerAt(y)
 if l <> 0 then
  l->Assign(x, "")
 end if

end sub
