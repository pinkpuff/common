#include once "sortedlist.bas"

type Set

 private:

 elements as SortedList

 public:

 declare function ContainsItem(item as String) as Boolean
 declare function ContainsPointer(item as Any ptr) as Boolean
 declare function ContainsValue(item as Integer) as Boolean
 declare function Contents() as List
 declare function Empty() as Boolean
 declare function SameAs(other as Set) as Boolean
 declare function Size() as UInteger
 declare function SubsetOf(other as Set) as Boolean
 declare function SupersetOf(other as Set) as Boolean

 declare sub AddItem(item as String)
 declare sub AddItems(items as List)
 declare sub AddPointer(item as Any ptr)
 declare sub AddPointers(items as List)
 declare sub AddValue(item as Integer)
 declare sub AddValues(items as List)
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


function Set.Empty() as Boolean

 return Size() = 0

end function


function Set.SameAs(other as Set) as Boolean

 return SupersetOf(other) and SubsetOf(other)

end function


function Set.Size() as UInteger

 return elements.Length()

end function


function Set.SubsetOf(other as Set) as Boolean

 dim result as Boolean = true
 
 for i as Integer = 1 to Size()
  if not other.ContainsItem(elements.ItemAt(i)) then
   result = false
   exit for
  end if
 next
 
 return result

end function


function Set.SupersetOf(other as Set) as Boolean

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


sub Set.AddItem(item as String)

 if not elements.ContainsItem(item) then elements.AddItem(item)

end sub


sub Set.AddItems(items as List)

 for i as Integer = 1 to items.Length()
  AddItem(items.ItemAt(i))
 next

end sub


sub Set.AddPointer(item as Any ptr)

 if not elements.ContainsPointer(item) then elements.AddPointer(item)
 
end sub


sub Set.AddPointers(items as List)

 for i as Integer = 1 to items.Length()
  AddPointer(items.PointerAt(i))
 next

end sub


sub Set.AddValue(item as Integer)

 if not elements.ContainsValue(item) then elements.AddValue(item)
 
end sub


sub Set.AddValues(items as List)

 for i as Integer = 1 to items.Length()
  AddValue(items.ValueAt(i))
 next

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
