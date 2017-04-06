class CardDateChanger
  def initialize(id)
    @id = id
  end

  def change_date
    card = Card.find(@id)
    card.review_date = Date.today + 3.days
    card.save
  end
end