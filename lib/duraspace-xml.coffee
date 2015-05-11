DuraspaceXmlView = require './duraspace-xml-view'
{CompositeDisposable} = require 'atom'

module.exports = DuraspaceXml =
  duraspaceXmlView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->

    @duraspaceXmlView = new DuraspaceXmlView(state.duraspaceXmlViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @duraspaceXmlView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'duraspace-xml:toggle': => @toggle()

  convert: ->

    Date::yyyymmdd = ->
      yyyy = @getFullYear().toString()
      mm = (@getMonth() + 1).toString()
      # getMonth() is zero-based
      dd = @getDate().toString()
      yyyy + (if mm[1] then mm else '0' + mm[0]) + (if dd[1] then dd else '0' + dd[0])
      # padding

    d = new Date
    $date = d.yyyymmdd()
    editor = atom.workspace.activePaneItem
    $text = editor.getText()
    $text = $text.replace(/20uu9999/g, $date)
    $text = $text.replace(/\&\#xA9\;/g, '&amp;#0169;')
    $text = $text.replace(/\&\#x201C\;|\&\#x201D\;|\&\#x2019\;|\&\#x2018\;/gi, '\'')
    $text = $text.replace(/\&\#x2013\;|\&\#x2014\;/gi, '-')
    $text = $text.replace(/\&\#xD\;/g, ' ')
    $text = $text.replace(/\&\#x2009\;/g, ' ')
    $text = $text.replace(RegExp('  ', 'g'), ' ')
    $text = $text.replace(RegExp(' \<', 'g'), '<')
    $text = $text.replace(RegExp(' \>', 'g'), '<')
    editor.setText $text

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @duraspaceXmlView.destroy()

  serialize: ->
    duraspaceXmlViewState: @duraspaceXmlView.serialize()

  toggle: ->
    @convert()
    console.log 'DuraSpace XML - convert activated'
