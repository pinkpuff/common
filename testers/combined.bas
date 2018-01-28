#include once "../ui/menu.bas"
#include once "../ui/numberinput.bas"

dim m as Menu = Menu(1, 1)
dim n as NumberInput = NumberInput(10, 1)
dim ages as List
dim key as Long
dim mode as String = "menu"
dim done as Boolean

m.AddOption("Ron")
m.AddOption("Marsha")
m.AddOption("Stephen")
m.AddOption("Graham")

ages.AddValue(38)
ages.AddValue(50)
ages.AddValue(54)
ages.AddValue(56)

cls
do
 select case mode
 case "menu"
  n.ChangeValue(ages.ValueAt(m.SelectedIndex()))
  m.Display()
  n.Display()
  key = getkey
  if key = TAB_KEY then
   mode = "number"
   n.Highlight()
  else
   done = m.HandleKey(key)
  end if
 case "number"
  m.Display()
  n.Display()
  key = getkey
  if key = TAB_KEY then
   mode = "menu"
   n.UnHighlight()
  else
   done = n.HandleKey(key)
   if done and not n.Cancelled() then
    done = false
    ages.AssignValue(m.SelectedIndex(), n.CurrentValue())
    mode = "menu"
    n.UnHighlight()
   end if
  end if
 end select
loop until done

