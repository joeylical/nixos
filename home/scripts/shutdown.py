#!/usr/bin/env python
import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk
import os

class ShutdownDialog(Gtk.Dialog):
    def __init__(self, parent):
        super().__init__(title="Shutdown?", transient_for=parent)

        self.add_buttons(Gtk.STOCK_NO, Gtk.ResponseType.NO, Gtk.STOCK_YES,
                         Gtk.ResponseType.YES)

        self.set_default_size(150, 100)

        label = Gtk.Label("Confirm to shutdown this computer?")

        box = self.get_content_area()
        box.add(label)
        self.show_all()

def show_shutdown_dialog():
    dialog = ShutdownDialog(None)

    response = dialog.run()
    if response == Gtk.ResponseType.YES:
        os.system('systemctl poweroff')

    dialog.destroy()

show_shutdown_dialog()

