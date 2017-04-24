class SetCurrentDeck
  include Interactor

  def call
    decks = Deck.all
    deck = decks.find(context.id)

    if deck.current
      deck.update(current: false)
      context.notice = 'Нет текущих колод'
    else
      decks.each { |d| d.update(current: false) }
      deck.update(current: true)
      context.notice = "Текущая колода #{deck.name}"
    end
  end
end
