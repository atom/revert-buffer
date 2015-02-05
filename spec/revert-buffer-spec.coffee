fs = require 'fs'
temp = require 'temp'

RevertBuffer = require '../lib/revert-buffer'

describe "RevertBuffer", ->
  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('revert-buffer')

  describe "revert-buffer:revert", ->
    it "reverts the buffer to the disk contents", ->
      editor = null
      filePath = temp.openSync('revert-buffer').path
      fs.writeFileSync(filePath, "Original Recipe")

      waitsForPromise ->
        atom.workspace.open(filePath)

      runs ->
        editor = atom.workspace.getActiveTextEditor()
        editor.setText("Extra Crispy")
        atom.commands.dispatch(atom.views.getView(editor), 'revert-buffer:revert')

      waitsFor ->
        editor.getText() is "Original Recipe"
