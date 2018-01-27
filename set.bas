#include once "sortedlist.bas"

type Set

 private:

 elements as SortedList

 public:

 declare function ContainsItem(item as String) as Boolean
 declare function ContainsPointer(item as Any ptr) as Boolean
 declare function ContainsValue(item as Integer) as Boolean
 declare function Contents() as List
 declare function IsEmpty() as Boolean
 declare function IsSubsetOf(other as Set) as Boolean
 declare function IsSupersetOf(other as Set) as Boolean
 declare function Size() as UInteger

 declare sub AddItem(item as String)
 declare sub AddPointer(item as Any ptr)
 declare sub AddValue(item as Integer)
 declare sub Destroy()
 declare sub IntersectWith(other as Set)
 declare sub RemoveItem(item as String)
 declare sub RemovePointer(item as Any ptr)
 declare sub RemoveValue(item as Integer)
 declare sub Subtract(other as Set)
 declare sub UnionWith(other as Set)

end type


function Set.ContainsItem(item as String) as Boolean

 return elements.ContainsItem(item)

end function


function Set.ContainsPointer(item as Any ptr) as Boolean

 return elements.ContainsPointer(item)

end function


function Set.ContainsValue(item as Integer) as Boolean

 return elements.ContainsValue(item)

end function


function Set.Contents() as List

 return elements.ItemList()

end function


function Set.IsEmpty() as Boolean

 return Size() = 0

end function


function Set.IsSubsetOf(other as Set) as Boolean

 dim result as Boolean = true
 
 for i as Integer = 1 to Size()
  if not other.ContainsItem(elements.ItemAt(i)) then
   result = false
   exit for
  end if
 next
 
 return result

end function


function Set.IsSupersetOf(other as Set) as Boolean

 dim result as Boolean = true
 dim c as List
 
 c = other.Contents() 
 for i as Integer = 1 to c.Length()
  if not ContainsItem(c.ItemAt(i)) then
   result = false
   exit for
  end if
 next
 
 return result

end function


function Set.Size() as UInteger

 return elements.Length()

end function


sub Set.AddItem(item as String)

 if not elements.ContainsItem(item) then elements.AddItem(item)

end sub


sub Set.AddPointer(item as Any ptr)

 if not elements.ContainsPointer(item) then elements.AddPointer(item)
 
end sub


sub Set.AddValue(item as Integer)

 if not elements.ContainsValue(item) then elements.AddValue(item)
 
end sub


sub Set.Destroy()

 elements.Destroy()

end sub


sub Set.IntersectWith(other as Set)

 dim newelements as SortedList
 
 for i as Integer = 1 to Size()
  if other.ContainsItem(elements.ItemAt(i)) then newelements.AddItem(elements.ItemAt(i))
 next
 
 elements = newelements

end sub


sub Set.RemoveItem(item as String)

 elements.RemoveItem(item)

end sub


sub Set.RemovePointer(item as Any ptr)

 elements.RemovePointer(item)

end sub


sub Set.RemoveValue(item as Integer)

 elements.RemoveValue(item)
 
end sub


sub Set.Subtract(other as Set)

 dim c as List
 
 c = other.Contents()
 for i as Integer = 1 to c.Length()
  RemoveItem(c.ItemAt(i))
 next

end sub


sub Set.UnionWith(other as Set)

 dim c as List
 
 c = other.Contents()
 for i as Integer = 1 to c.Length()
  AddItem(c.ItemAt(i))
 next

end sub
