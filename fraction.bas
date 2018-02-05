#include once "functions\roll.bas"

type Fraction

 numerator as Integer
 denominator as Integer = 1
 
 declare constructor(starting_numerator as Integer = 0, starting_denominator as Integer = 1)
 
 declare function Decimal() as Double
 declare function Roll() as Boolean
 
 declare sub DivideFraction(operand as Fraction)
 declare sub DivideScalar(scalar as Integer)
 declare sub TimesFraction(operand as Fraction)
 declare sub TimesScalar(scalar as Integer)

end type


constructor Fraction(starting_numerator as Integer = 0, starting_denominator as Integer = 1)

 numerator = starting_numerator
 if starting_denominator <> 0 then denominator = starting_denominator

end constructor


function Fraction.Decimal() as Double

 return numerator / denominator

end function


function Fraction.Roll() as Boolean

 return cbool(RollDie(denominator) <= numerator)

end function


sub Fraction.DivideFraction(operand as Fraction)

 if operand.numerator <> 0 then
  numerator *= operand.denominator
  denominator *= operand.numerator
 end if

end sub


sub Fraction.DivideScalar(scalar as Integer)

 if scalar <> 0 then denominator *= scalar

end sub


sub Fraction.TimesFraction(operand as Fraction)

 numerator *= operand.numerator
 denominator *= operand.denominator

end sub


sub Fraction.TimesScalar(scalar as Integer)

 numerator *= scalar

end sub


