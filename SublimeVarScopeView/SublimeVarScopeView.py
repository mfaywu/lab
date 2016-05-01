'''
SublimeVarScopeView
A SublimeText 3 plugin for viewing the scopes of different variables in the code. 

@author M Fay Wu
'''

import sublime, sublime_plugin, re

print_lines = ["Variables\n"]

#view.run_command('example')
class ExampleCommand(sublime_plugin.TextCommand):
        def run(self, edit):
                self.view.insert(edit, 0, "Hello, World!")

class PrintCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        window = sublime.active_window()
        view = window.views()[1]
        for lines in print_lines:
            view.insert(edit, view.size(), lines + "\n")
            print ("printing command")

class AddVarsCommand(sublime_plugin.TextCommand):
    def run(self, text):
        view = self.view
    view.find_all('\bvar\s+(\K\S+)', sublime.IGNORECASE, '',print_lines)
    for word in print_lines:
        print(word)

#window.run_command('setup')
class SetupCommand(sublime_plugin.WindowCommand):
        def run(self):
                self.window.run_command('set_layout', {"cols":[0.0, 0.8, 1], "rows":[0.0, 1.0], "cells":[[0,0,1,1],[1,0,2,1]]})
                self.window.run_command('print')
                print ("change window!")

#Notes for self - 
#window.active_view().id() = view.id() = 22, 24
#window.views()[1].id() = second view
# To print onto view2
#window.focus_view(window.views()[1])
#view.run_command('example')
