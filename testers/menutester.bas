# include "../ui/menu.bas"

dim m as Menu =  Menu(1, 1, 3)

m.AddOption("One")
m.AddOption("Two")
m.AddOption("Three")
m.AddOption("Four")
m.AddOption("Five")
m.AddOption("Six")
cls
m.UserSelect()
if m.Cancelled() then print "--Cancelled"
locate ,,1

