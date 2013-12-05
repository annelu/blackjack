#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    # @set 'stack', 1000
  getScore: ->
    playerScore = @get('playerHand').scores()
    dealerScore = @get('dealerHand').scores()
    [playerScore, dealerScore]
  compareScore: ->
    scores = @getScore()
    if scores[0] > scores[1]
      @trigger('playerwin', @)
    else
      @trigger('dealerwin', @)
  stack: 1000
