require 'rails_helper'
describe CheckTranslation do
  before do
    @card = create(:card)
    @params = { id: @card.id, user_text: 'home' }
  end

  it 'return positive notice if answer is correct' do
    check_card = CheckTranslation.call(@params)
    expect(check_card.notice).to include "Вы ответили правильно."
  end

  it 'return negative notice if answer is incorrect' do
    @params[:user_text] = 'wrong translation'
    check_card = CheckTranslation.call(@params)
    expect(check_card.notice).to include "Вы ответили неправильно."
  end
end
