class window.Hand extends Backbone.Collection

  model: Card

  initialize: (@array, @deck, @isDealer, @betAmount) ->

  hit: ->
    @add(@deck.pop()).last()

  hasStood: false

  stand: ->
    if @isDealer
      @hasStood = true
      @array[0].flip()
      while @scores().pop() < 17
        @hit()
      if @scores().pop() > 21 then @.trigger('bust', @)
    @.trigger('getScore', @)

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get 'revealed' then card.get 'value' else 0
    , 0
    if score > 21 && !hasAce then @.trigger('lose', @)
    if @isDealer and hasAce and !@hasStood
      if @array[1].attributes.rankName == "Ace"
        [score + 10]
      else
        [score]
    else
      if hasAce and (score + 10 <= 21)
        [score + 10]
      else
        [score]
