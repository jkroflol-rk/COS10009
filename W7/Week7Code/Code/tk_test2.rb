require 'tk'

root = TkRoot.new
root.title = "Window"

text = TkText.new(root) do
   width 30
   height 20
   borderwidth 1
   background "gray"
   font TkFont.new('times 12 bold')
   grid('row'=>0, 'column'=>0)
end
text.insert 'end', "Hello!\n\ntext widget example"

Tk.mainloop
