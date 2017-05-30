#include once "tokenize.bas"

function InitialCaps(s as String) as String

 dim result as String
 dim tokens as List
 dim token as String

 tokens = Tokenize(s)
 for i as Integer = 1 to tokens.Length()
  token = tokens.ItemAt(i)
  result += ucase(left(token, 1)) + lcase(mid(token, 2)) + " "
 next
 result = rtrim(result)

 return result

end function
