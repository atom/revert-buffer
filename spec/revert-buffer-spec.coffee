{WorkspaceView} = require 'atom'
fs = require 'fs-plus'
temp = require 'temp'

RevertBuffer = require '../lib/revert-buffer'

describe "RevertBuffer", ->
  beforeEach ->
    atom.workspaceView = new WorkspaceView
    atom.packages.activatePackage('revert-buffer', immediate: true)

  describe "revert-buffer:revert", ->
    it "reverts the buffer to the disk contents", ->
      filePath = temp.openSync('revert-buffer').path
      fs.writeFileSync(filePath, "Original Recipe")
      editor = atom.workspaceView.openSync(filePath)
      editor.setText("Extra Crispy")

      atom.workspaceView.getActiveView().trigger 'revert-buffer:revert'

      waitsFor ->
        editor.getText() == "Original Recipe"
