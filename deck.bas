#include once "functions/roll.bas"

type Deck

 private:
 
 cards as List
 
 public:

 declare function Draw() as String
 declare function DrawCards(amount as UInteger) as List
 declare function Size() as UInteger
 declare function Top() as String

 declare sub AddCard(label as String)
 declare sub Destroy()
 declare sub Shuffle()

end type


function Deck.Draw() as String

 dim result as String

 result = cards.ItemAt(1)
 cards.RemoveIndex(1)

 return result

end function


function Deck.DrawCards(amount as UInteger) as List

 dim result as List

 result = cards.Slice(1, amount)
 cards = cards.Slice(amount + 1, cards.Length())

 return result

end function


function Deck.Size() as UInteger

 return cards.Length()

end function


function Deck.Top() as String

 return cards.ItemAt(1)

end function


sub Deck.AddCard(label as String)

 cards.AddItem(label)

end sub


sub Deck.Destroy()

 cards.Destroy()

end sub


sub Deck.Shuffle()

 for i as Integer = 1 to cards.Length()
  cards.Exchange(i, RollDie(cards.Length() - i + 1) + i - 1)
 next

end sub

