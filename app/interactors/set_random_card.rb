class SetRandomCard
  include Interactor

  def call
    user = context.user
    context.card = if user.current_deck
                     random_card(user.current_deck)
                   else
                     random_card(user)
                   end
  end

  private

  def random_card(model)
    model.cards.with_ready_date.random.first
  end
end
