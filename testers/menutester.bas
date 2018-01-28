# include "../ui/menu.bas"

dim m as Menu =  Menu(10, 10, 3, 1, 1)

m.AddOption("One")
m.AddOption("Two")
m.AddOption("Three")
m.AddOption("Four")
m.AddOption("Five")
m.AddOption("Six")
cls
m.UserInput()
if m.Cancelled() then
 print "--Cancelled"
else
 print str(m.SelectedIndex())
 print m.SelectedItem()
end if
locate ,,1

