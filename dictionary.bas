#include once "set.bas"

type Dictionary

 keys as Set
 values as List

 declare function ValueOf(key as String) as String
 declare function PointerOf(key as String) as Any ptr

 declare sub Assign overload (key as String, value as String)
 declare sub Assign overload (key as String, value as Any ptr)

end type


function Dictionary.ValueOf(key as String) as String

 return values.ItemAt(keys.IndexOf(key))

end function


function Dictionary.PointerOf(key as String) as Any ptr

 return values.PointerAt(keys.IndexOf(key))

end function


sub Dictionary.Assign(key as String, value as String)

 keys.AddItem(key)
 values.Assign(keys.IndexOf(key), value)

end sub


sub Dictionary.Assign(key as String, value as Any ptr)

 keys.AddItem(key)
 values.Assign(keys.IndexOf(key), value)

end sub


