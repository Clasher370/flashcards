class SuperMemo
  def initialize(id, user_text, timer)
    @card = Card.find(id)
    @user_text = user_text
    @timer = timer.to_i
  end

  def algorithm
    compare_result = compare(@card.original_text, @user_text)
    quality = quality_of_repetition(compare_result, @timer)
    update_card(@card, quality)
    create_notice(@card, @user_text, quality)
  end

  private

  def update_card(card, quality)
    current_stage = card.review_stage
    if quality > 2
      card.update(review_date: update_interval(card, current_stage),
                  easiness: update_easiness(card, quality),
                  review_stage: current_stage + 1)
    else
      card.update(review_stage: 1,
                  review_date: update_interval(card, 1))
    end
  end

  def compare(text_one, text_two)
    DamerauLevenshtein.distance(text_one.downcase, text_two.downcase, 0)
  end

  def quality_of_repetition(compare_result, seconds)
    return 0 if compare_result > 2
    return 5 if compare_result.zero? && seconds <= 15
    return 4 if compare_result.zero? && (seconds > 15 && seconds <= 45)
    return 3 if compare_result.zero? && seconds > 45
    return 2 if compare_result == 1
    1 if compare_result == 2
  end

  def update_easiness(card, quality)
    return 1.3 if card.easiness < 1.3

    card.easiness + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
  end

  def update_interval(card, stage)
    date = if stage == 1
             1
           elsif stage == 2
             6
           elsif stage > 2
             ((stage - 1) * card.easiness).round
           end
    date.hour.since
  end

  def create_notice(card, text, quality)
    return I18n.t('dashboard.flashcards.correct') if quality > 2
    I18n.t('dashboard.flashcards.incorrect', user_text: text,
                                   translated_text: card.translated_text,
                                   original_text: card.original_text)
  end
end
