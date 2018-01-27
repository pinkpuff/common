#include once "set.bas"

type Dictionary

 private:
 keys as Set
 values as List

 public:
 declare function IsValidKey(key as String) as Boolean
 declare function ValueOf(key as String) as String
 declare function PointerOf(key as String) as Any ptr

 declare sub Assign overload (key as String, value as String)
 declare sub Assign overload (key as String, value as Any ptr)
 declare sub Destroy()

end type


function Dictionary.IsValidKey(key as String) as Boolean

 return keys.Contains(key)

end function


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


sub Dictionary.Destroy()

 keys.Destroy()
 values.Destroy()

end sub
