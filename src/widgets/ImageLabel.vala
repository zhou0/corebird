
using Gtk;

/**
 * Displays an icon on the left/right side of the
 * specified text. Helps to reduce the complexity of layouts.
 */
class ImageLabel : Label {
	/** The icon to display */
	public Gdk.Pixbuf icon {get; set;}
	/** The gap between icon and text */
	public int gap{get; set; default = 2;}
	public Gtk.PositionType icon_pos = Gtk.PositionType.LEFT;


	public ImageLabel(string text){
		this.label = text;
	}

	public override bool draw(Cairo.Context c){
		StyleContext context = this.get_style_context();
		if(icon_pos == PositionType.LEFT){
			context.render_icon(c, icon, 0, 0);
			c.translate(icon.width + gap, 0);
			base.draw(c);
		} else {
			base.draw(c);
			c.translate(base.get_allocated_width() - icon.width, 0);
			context.render_icon(c, icon, 0, 0);
		}


		return false;
	}

    public override void size_allocate (Allocation allocation) {
    	allocation.width += icon.width + gap;
	    base.size_allocate (allocation);
	}
}