class ChangeCardDate
  include Interactor

  def call
      card = Card.find(context.card)
      card.review_date = Date.today + 3.days
      card.save
  end
end