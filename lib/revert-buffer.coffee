module.exports =
  activate: ->
    atom.commands.add 'atom-text-editor', 'revert-buffer:revert', ->
      editor = atom.workspace.getActiveTextEditor()
      return unless editor?.getPath()

      fs = require 'fs'
      fs.readFile editor.getPath(), (error, contents) ->
        editor.setText(contents.toString()) unless error
