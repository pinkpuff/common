'#include once "binarytree.bas"
#include once "sortedlist.bas"

type Set

 private:

 'elements as BinaryTree
 'elements as List
 elements as SortedList

 public:

 declare function Contains(item as String) as Boolean
 declare function Contents() as List
 declare function IsEmpty() as Boolean
 declare function IsSubsetOf(other as Set) as Boolean
 declare function IsSupersetOf(other as Set) as Boolean
 declare function Size() as UInteger

 declare sub AddItem(item as String)
 declare sub Destroy()
 declare sub IntersectWith(other as Set)
 declare sub Remove(item as String)
 declare sub Subtract(other as Set)
 declare sub UnionWith(other as Set)

end type


function Set.Contains(item as String) as Boolean

 return elements.Contains(item)

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
  if not other.Contains(elements.ItemAt(i)) then
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
  if not Contains(c.ItemAt(i)) then
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

 if not elements.Contains(item) then elements.AddItem(item)

end sub


sub Set.Destroy()

 elements.Destroy()

end sub


sub Set.IntersectWith(other as Set)

 dim newelements as SortedList
 
 for i as Integer = 1 to Size()
  if other.Contains(elements.ItemAt(i)) then newelements.AddItem(elements.ItemAt(i))
 next
 
 elements = newelements

end sub


sub Set.Remove(item as String)

 elements.RemoveItem(item)

end sub


sub Set.Subtract(other as Set)

 dim c as List
 
 c = other.Contents()
 for i as Integer = 1 to c.Length()
  Remove(c.ItemAt(i))
 next

end sub


sub Set.UnionWith(other as Set)

 dim c as List
 
 c = other.Contents()
 for i as Integer = 1 to c.Length()
  AddItem(c.ItemAt(i))
 next

end sub
