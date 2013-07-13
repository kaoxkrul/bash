#!/usr/bin/env python

import sys
import os

import gobject
import gtk
import pango

class ElapsedTime(gtk.Window):
    def __init__(self, parent=None):
        # Create the toplevel window
        gtk.Window.__init__(self)
        try:
            self.set_screen(parent.get_screen())
        except AttributeError:
            self.connect('destroy', lambda *w: gtk.main_quit())

        """self.set_title(self.__class__.__name__)"""
        self.set_title("Elapsed Time")
        self.set_default_size(550, 600)
        self.set_border_width(0)

        vpaned = gtk.VPaned()
        vpaned.set_border_width(5)
        self.add(vpaned)

        # For convenience, we just use the autocreated buffer from
        # the first text view; you could also create the buffer
        # by itself with gtk.text_buffer_new(), then later create
        # a view widget.

        view1 = gtk.TextView();
        view1.modify_base(gtk.STATE_NORMAL, gtk.gdk.color_parse("black"))
        buffer_1 = view1.get_buffer()

        sw = gtk.ScrolledWindow()
        sw.set_shadow_type(gtk.SHADOW_ETCHED_IN)
        sw.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)

        vpaned.add1(sw)

        sw.add(view1)

        sw = gtk.ScrolledWindow()
        sw.set_shadow_type(gtk.SHADOW_ETCHED_IN)
        sw.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)

        self.create_tags(buffer_1)
        self.insert_text(buffer_1)

        self.win = None
        self.show_all()

    def create_tags(self, text_buffer):

        import pango
        text_buffer.create_tag("heading",
                    weight=pango.WEIGHT_BOLD,
                    size=150 * pango.SCALE,
                    family="lcd",
                    background="black", foreground="red",
                    justification=gtk.JUSTIFY_RIGHT)

        text_buffer.create_tag("word_wrap", wrap_mode=gtk.WRAP_WORD)

    def insert_text(self, text_buffer):

        # get start of buffer; each insertion will revalidate the
        # iterator to point to just after the inserted text.
        iter = text_buffer.get_iter_at_offset(0)

        text_buffer.insert_with_tags_by_name(iter, "3.231\n", "heading")

        iter = text_buffer.get_iter_at_offset(0)

        text_buffer.insert_with_tags_by_name(iter, "2.331\n", "heading")

        # Apply word_wrap tag to whole buffer */
        start, end = text_buffer.get_bounds()
        text_buffer.apply_tag_by_name("word_wrap", start, end)

def main():
    ElapsedTime()
    gtk.main()

if __name__ == '__main__':
    main()
