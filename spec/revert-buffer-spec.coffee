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

  describe "revert-buffer:revert-all", ->
    it "reverts the buffer (from all editors) to the disk contents", ->
      editor1 = null
      editor2 = null
      filePath1 = temp.openSync('revert-buffer-1').path
      fs.writeFileSync(filePath1, "Original Recipe 1")
      filePath2 = temp.openSync('revert-buffer-2').path
      fs.writeFileSync(filePath2, "Original Recipe 2")

      waitsForPromise ->
        atom.workspace.open(filePath1)
      
      waitsForPromise ->
        atom.workspace.open(filePath2)

      runs ->
        editor1 = atom.workspace.getTextEditors()[0]
        editor1.setText("Extra Crispy 1")
        editor2 = atom.workspace.getTextEditors()[1]
        editor2.setText("Extra Crispy 2")
        atom.commands.dispatch(atom.views.getView(editor1), 'revert-buffer:revert-all')

      waitsFor ->
        editor1.getText() is "Original Recipe 1"
      
      waitsFor ->
        editor2.getText() is "Original Recipe 2"
