{fs} = require 'atom'

module.exports =
  activate: ->
    atom.workspaceView.command 'revert-buffer:revert', =>
      editor = atom.workspaceView.getActivePaneItem()
      fs.readFile editor.getPath(), (error, contents) ->
        editor.setText(contents.toString()) unless error
