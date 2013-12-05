class window.CardView extends Backbone.View

  className: 'card'

  template: _.template ''

  template: _.template '<div class="hobo"></div><img class="cards" src="cards/<%= rankName %>-<%= suitName %>.png">'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    @$el.html @template @model.attributes
    #@$el.addClass 'covered' unless @model.get 'revealed'
    $(@$el.children()[0]).addClass 'covered' unless @model.get 'revealed'
