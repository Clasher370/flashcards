class CheckTranslation
  include Interactor

  def call
    card = Card.find(context.id)
    if compare_text(card.original_text, context.user_text)
      change_time_and_stage(card)
    else
      try_card(card)
    end
  end

  private

  def compare_text(text_one, text_two)
    text_one.downcase == text_two.downcase
  end

  def change_time_and_stage(card)
    stage_time = { 1 => 12.hour.since, 2 => 3.days.since, 3 => 1.week.since, 4 => 3.week.since, 5 => 1.month.since }
    key = card.review_stage.to_i
    next_date = stage_time[key]
    next_stage = key < 5 ? key + 1 : 5

    update_args_of(card, next_date, next_stage)
    change_context('Вы ответили правильно.')
  end

  def try_card(card)
    try = context.session_try
    if try == ''
      change_context(message(2), 1, card)
    elsif try == '1'
      change_context(message(1), 2, card)
    elsif try == '2'
      change_context('Вы ответили неправильно.')
      update_args_of(card, 12.hour.since, 1)
    end
  end

  def message(try)
    "Вы ответили неправильно. Осталось #{try} попытки."
  end

  def update_args_of(model, time, stage)
    model.update(review_date: time, review_stage: stage)
  end

  def change_context(message, try = nil, model = nil)
    context.card = model ? model.id : model
    context.session_try = try
    context.notice = message
  end
end
