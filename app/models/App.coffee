#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
  getScore: ->
    playerScore = @model.get('playerHand').on('getScores', @.get(scores()))
    dealerScore = @model.get('dealerHand').on('getScores', @.get(scores()))
    console.log(playerScore);
    console.log(dealerScore);