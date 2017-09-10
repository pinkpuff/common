#include once "../set.bas"

function Tokenize(byval s as String, delimiters as String = " ") as List

 dim result as List
 dim n as UInteger
 dim d as Set
 dim token as String
 dim readmode as Boolean

 for i as Integer = 1 to len(delimiters)
  d.AddItem(mid(delimiters, i, 1))
 next
 
 s = ltrim(s)

 for i as Integer = 1 to len(s)
  if d.ContainsItem(mid(s, i, 1)) then
   if readmode then
    readmode = false
    result.AddItem(token)
    token = ""
   end if
  else
   readmode = true
   token += mid(s, i, 1)
  end if
 next
 if readmode then result.AddItem(token)
 
 return result

end function
