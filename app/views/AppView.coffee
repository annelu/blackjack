class window.AppView extends Backbone.View

  template: _.template '
    <div class="win-container"><div class="button-container"><button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button></div></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="stack"></div>
  '

  events:
    "click .hit-button": -> @model.get('playerHand').hit()
    "click .stand-button": ->
      @model.get('dealerHand').stand()
      @model.get('playerHand').stand()
      $('.button-container').html('<h3>Waiting for Dealer</h3>')
    "click .playagain": ->
      @model.initialize()
      @.initialize()

  initialize: ->
    bet = @model.get('playerHand').betAmount
    stack = @model.stack
    @model.stack = stack - bet
    # $('body').html("");
    that = @
    @render()
    @$('.stack').html('<h3>Your stack is: ' + @model.stack + '</h3>')
    @model.get('playerHand').on('lose', -> $('.button-container').html('<h3>You Lose</h3><button class="playagain">Do you want to play again?</button>'))
    @model.get('dealerHand').on('bust', -> $('.win-container').html('<h3>Dealer Busts!  You Win!</h3><button class="playagain">Do you want to play again?</button>'))
    @model.get('dealerHand').on('getScore', -> that.model.compareScore())
    @model.on('playerwin', ->
      # @model.stack = stack + (bet * 2)
      $('.win-container').html('<h3>You Win!</h3><button class="playagain">Do you want to play again?</button>'))
    @model.on('dealerwin', -> $('.win-container').html('<h3>Dealer Wins!</h3><button class="playagain">Do you want to play again?</button>'))

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
