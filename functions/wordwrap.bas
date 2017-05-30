#include once "tokenize.bas"

function WordWrap(s as String, w as Integer) as List

 dim result as List
 dim tokens as List
 dim l as String

 tokens = Tokenize(s)

 for i as Integer = 1 to tokens.Length()
  if len(l) = 0 then
   if len(tokens.ItemAt(i)) > w then
    l = left(tokens.ItemAt(i), w - 1) + "-"
    result.Append(l)
    l = ""
    tokens.Assign(i, mid(tokens.ItemAt(i), w))
    i -= 1
   else
    l = tokens.ItemAt(i)
   end if
  else
   if w - len(l) < len(tokens.ItemAt(i)) then
    result.Append(l)
    l = ""
    i -= 1
   else
    l += " " + tokens.ItemAt(i)
   end if
  end if 
 next

 result.Append(l)

 return result 

end function
