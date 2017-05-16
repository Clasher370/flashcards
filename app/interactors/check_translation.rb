class CheckTranslation
  include Interactor

  def call
    card = Card.find(context.id)
    if compare_text(card.original_text, context.user_text)
      change_date(card)
      context.notice = 'Вы ответили правильно.'
    else
      context.notice = 'Вы ответили неправильно.'
    end
  end

  private

  def compare_text(text_one, text_two)
    text_one.downcase == text_two.downcase
  end

  def change_date(card)
    if card.review_stage == 'first'
      card.update(review_date: 12.hour.since, review_stage: 'second')
    elsif card.review_stage == 'second'
      card.update(review_date: 3.days.since, review_stage: 'third')
    elsif card.review_stage == 'third'
      card.update(review_date: 1.week.since, review_stage: 'fourth')
    elsif card.review_stage == 'fourth'
      card.update(review_date: 3.week.since, review_stage: 'last')
    elsif card.review_stage == 'last'
      card.update(review_date: 1.month.since, review_stage: 'last')
    end
  end
end
