require 'tk'

# https://tkdocs.com/tutorial/windows.html

root = TkRoot.new
root.title = "Window"

filename = Tk::getOpenFile

Tk::messageBox :message => "File is" + filename


Tk.mainloop
