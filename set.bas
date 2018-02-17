#include once "sortedlist.bas"

type Set
 private:
  elements as SortedList
 public:
  declare operator +=(rhs as Set)
  declare operator +=(rhs as List)
  declare operator +=(rhs as String)
  declare operator +=(rhs as Any ptr)
  declare operator +=(rhs as Long)
  declare operator -=(rhs as List)
  declare operator -=(rhs as String)
  declare operator -=(rhs as Any ptr)
  declare operator -=(rhs as Long)
  declare operator *=(rhs as Set)
  declare operator *=(rhs as List)
  declare function ContainsItem(item as String) as Boolean
  declare function ContainsPointer(item as Any ptr) as Boolean
  declare function ContainsValue(item as Long) as Boolean
  declare function Contents() as List
  declare function Empty() as Boolean
  declare function SameAs(other as Set) as Boolean
  declare function Size() as Long
  declare function SubsetOf(other as Set) as Boolean
  declare function SupersetOf(other as Set) as Boolean
  declare sub AddItem(item as String)
  declare sub AddList(items as List)
  declare sub AddPointer(item as Any ptr)
  declare sub AddValue(item as Long)
  declare sub Destroy()
  declare sub IntersectWith(other as Set)
  declare sub RemoveItem(item as String)
  declare sub RemovePointer(item as Any ptr)
  declare sub RemoveValue(item as Long)
  declare sub Subtract(other as Set)
  declare sub UnionWith(other as Set)
end type

declare operator +(lhs as Set, rhs as Set) as Set
declare operator *(lhs as Set, rhs as Set) as Set
declare operator -(lhs as Set, rhs as Set) as Set

operator +(lhs as Set, rhs as Set) as Set
 dim result as Set
 result += lhs
 result += rhs
 return result
end operator

operator *(lhs as Set, rhs as Set) as Set
 dim result as Set
 result += lhs
 result *= rhs
 return result
end operator

operator -(lhs as Set, rhs as Set) as Set
 dim result as Set
 result += lhs
 result -= rhs
 return result
end operator

operator Set.+=(rhs as Set)
 UnionWith(rhs)
end operator

operator Set.+=(rhs as List)
 AddList(rhs)
end operator

operator Set.+=(rhs as String)
 AddItem(rhs)
end operator

operator Set.+=(rhs as Any ptr)
 AddPointer(rhs)
end operator

operator Set.+=(rhs as Long)
 AddValue(rhs)
end operator

operator Set.-=(rhs as List)
 for i as Long = 1 to rhs.Size()
  RemoveItem(rhs.ItemAt(i))
 next
end operator

operator Set.-=(rhs as String)
 RemoveItem(rhs)
end operator

operator Set.-=(rhs as Any ptr)
 RemovePointer(rhs)
end operator

operator Set.-=(rhs as Long)
 RemoveValue(rhs)
end operator

operator Set.*=(rhs as Set)
 IntersectWith(rhs)
end operator

operator Set.*=(rhs as List)
 for i as Long = 1 to rhs.Size()
  if not ContainsItem(rhs.ItemAt(i)) then
   RemoveItem(rhs.ItemAt(i))
  end if
 next
end operator

function Set.ContainsItem(item as String) as Boolean
 return elements.ContainsItem(item)
end function

function Set.ContainsPointer(item as Any ptr) as Boolean
 return elements.ContainsPointer(item)
end function

function Set.ContainsValue(item as Long) as Boolean
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

function Set.Size() as Long
 return elements.Size()
end function

function Set.SubsetOf(other as Set) as Boolean
 dim result as Boolean = true
 for i as Long = 1 to Size()
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
 for i as Long = 1 to c.Size()
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

sub Set.AddList(items as List)
 for i as Long = 1 to items.Size()
  AddItem(items.ItemAt(i))
 next
end sub

sub Set.AddPointer(item as Any ptr)
 if not elements.ContainsPointer(item) then elements.AddPointer(item)
end sub

sub Set.AddValue(item as Long)
 if not elements.ContainsValue(item) then elements.AddValue(item)
end sub

sub Set.Destroy()
 elements.Destroy()
end sub

sub Set.IntersectWith(other as Set)
 dim newelements as SortedList
 for i as Long = 1 to Size()
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

sub Set.RemoveValue(item as Long)
 elements.RemoveValue(item)
end sub

sub Set.Subtract(other as Set)
 dim c as List
 c = other.Contents()
 for i as Long = 1 to c.Size()
  RemoveItem(c.ItemAt(i))
 next
end sub

sub Set.UnionWith(other as Set)
 dim c as List
 c = other.Contents()
 for i as Long = 1 to c.Size()
  AddItem(c.ItemAt(i))
 next
end sub
