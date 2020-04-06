using Gtk

function button_connect(b)
  signal_connect(b, "clicked") do widget
    set_gtk_property!(ent,:text,string(get_gtk_property(ent,:text,String),get_gtk_property(widget,:label,String)))
    println("\"", get_gtk_property(widget,:label,String), "\" was clicked!")
  end
end
win = GtkWindow("A new window")
g = GtkGrid()
ent = GtkEntry()
numberedButtons = [1:9;] .|> string .|> GtkButton
# Now let's place these graphical elements into the Grid:
#g[1,1], g[2,1] = a,b   # Cartesian coordinates, g[x,y]
for x= 1:3,y = 1:3
  g[x,y+1] = numberedButtons[x+3(y-1)]
end
g[1:3,1] = ent
operations = [GtkButton("+"),GtkButton("-"),GtkButton("*"),GtkButton("/")]
g[1,5],g[2,5] ,g[3,5],g[1,6]  = operations[1],operations[2],operations[3],operations[4]
numberedButtons = numberedButtons .|> button_connect
operations = operations .|> button_connect

set_gtk_property!(g, :column_homogeneous, true)
set_gtk_property!(g, :column_spacing, 1)  # introduce a 15-pixel gap between columns
push!(win, g)
showall(win)
