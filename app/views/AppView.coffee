class window.AppView extends Backbone.View

  template: _.template '
    <div class="win-container"><div class="button-container"><button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button></div></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": ->
      @model.get('dealerHand').stand()
      $('.button-container').html('<h3>Waiting for Dealer</h3>')

  initialize: ->
    @render()
    @model.get('playerHand').on('lose', -> $('.button-container').html('<h3>You Lose</h3>'))
    @model.get('dealerHand').on('bust', -> $('.win-container').html('<h3>Dealer Busts!  You Win!</h3>'))

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
