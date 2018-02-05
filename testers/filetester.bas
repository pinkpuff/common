#include once "../ui/filebrowser.bas"

dim f as FileBrowser = FileBrowser(1, 1, "./", 1, 10)

cls
f.UserInput()
locate ,, 1
