'Many properties of things in FF4 are stored as ranges of indexes that
' have that property. This object doesn't really provide much in the
' way of functionality; it's mostly there just to help keep things
' organized.

type Range

 start as Integer
 finish as Integer
 
 declare function InRange(index as Integer) as Boolean
 declare sub SetRange(new_start as Integer, new_finish as Integer)
 declare function Size() as Integer
 
end type


function Range.InRange(index as Integer) as Boolean

 return iif(index >= start and index <= finish, true, false)

end function


sub Range.SetRange(new_start as Integer, new_finish as Integer)

 start = new_start
 finish = new_finish
 if finish < start then swap start, finish

end sub


function Range.Size() as Integer

 return finish - start + 1
 
end function
