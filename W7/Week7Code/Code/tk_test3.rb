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


btn_OK = TkButton.new(root) do
   text "Save File"
   borderwidth 5
   state "normal"
   cursor "watch"
   font TkFont.new('times 20 bold')
   foreground  "red"
   activebackground "blue"
   relief      "groove"
   command (proc {Tk::messageBox :message => 'Saved File'})
   grid('row'=>2, 'column'=>0)
 end


text.insert 'end', "Hello!\n\ntext widget example"



Tk.mainloop
