class CheckTranslation
  include Interactor

  def call
    card = Card.find(context.id)
    if compare_text(card.original_text, context.user_text)
      change_time_and_stage(card)
      change_context nil, nil, 'Вы ответили правильно.'
    else
      try_card(card)
    end
  end

  private

  def compare_text(text_one, text_two)
    text_one.downcase == text_two.downcase
  end

  # def change_time(card)
  #   case card.review_stage
  #   when 'second'
  #     update_args_of card, 3.days.since, 'third'
  #   when 'third'
  #     update_args_of card, 1.week.since, 'fourth'
  #   when 'fourth'
  #     update_args_of card, 3.week.since, 'last'
  #   when 'last'
  #     update_args_of card, 1.month.since, 'last'
  #   else
  #     update_args_of card, 12.hour.since, 'second'
  #   end
  # end

  def change_time_and_stage(card)
    stage_time = { 1 => 12.hour.since, 2 => 3.days.since, 3 => 1.week.since, 4 => 3.week.since, 5 => 1.month.since }
    key = card.review_stage.to_i

    card.update(review_date: stage_time[key], review_stage: key < 5 ? key + 1 : 5)
  end

  def try_card(card)
    if context.session_try == ''
      change_context card, 1, 'Вы ответили неправильно. Осталось 2 попытки.'
    elsif context.session_try == '1'
      change_context card, 2, 'Вы ответили неправильно. Осталось 1 попытки.'
    elsif context.session_try == '2'
      change_context nil, nil, 'Вы ответили неправильно.'
      update_args_of card, 12.hour.since, 1
    end
  end

  def update_args_of(card, time, stage)
    card.update(review_date: time, review_stage: stage)
  end

  def change_context(model, try, message)
    context.card = model ? model.id : model
    context.session_try = try
    context.notice = message
  end
end
