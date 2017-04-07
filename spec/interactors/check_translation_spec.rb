require 'rails_helper'

describe CheckTranslation do

  before do
    @card = create(:card)
  end

  it 'Возращает правильный ответ' do
    user_text = 'home'
    params = { id: @card.id, user_text: user_text }
    check_card = CheckTranslation.call(params)
    expect(check_card.notice).to include "Вы ответили правильно."
  end

  it 'Возращает правильный ответ' do
    user_text = 'Nohome'
    params = { id: @card.id, user_text: user_text }
    check_card = CheckTranslation.call(params)
    expect(check_card.notice).to include "Вы ответили неправильно."
  end



end
