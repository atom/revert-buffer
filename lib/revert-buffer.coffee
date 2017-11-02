module.exports =
  activate: ->
    atom.commands.add 'atom-text-editor', 'revert-buffer:revert', ->
      editor = atom.workspace.getActiveTextEditor()
      return unless editor?.getPath()

      fs = require 'fs'
      fs.readFile editor.getPath(), (error, contents) ->
        editor.setText(contents.toString()) unless error

    atom.commands.add 'atom-text-editor', 'revert-buffer:revert-all', ->
      fs = require 'fs'
      atom.workspace.getTextEditors().forEach (editor) ->
        if editor?.getPath()
          fs.readFile editor.getPath(), (error, contents) ->
            editor.setText(contents.toString()) unless error
