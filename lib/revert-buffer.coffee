fs = require 'fs-plus'

module.exports =
  activate: ->
    atom.workspaceView.command 'revert-buffer:revert', =>
      paneItem = atom.workspace.getActivePaneItem()

      return unless paneItem.getPath? and paneItem.setText?
      fs.readFile paneItem.getPath(), (error, contents) ->
        paneItem.setText(contents.toString()) unless error
