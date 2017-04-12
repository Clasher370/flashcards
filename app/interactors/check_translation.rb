class CheckTranslation
  include Interactor

  def call
    card = Card.find(context.id)
    if compare_text(card.original_text, context.user_text)
      card.update(review_date: 3.days.since)
      context.notice = 'Вы ответили правильно.'
    else
      context.notice = 'Вы ответили неправильно.'
    end
  end

  private

  def compare_text(text_one, text_two)
    text_one.downcase == text_two.downcase
  end
end
