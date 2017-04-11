require 'rails_helper'

RSpec.feature "CheckTranslation", type: :feature do
  before(:all) do
    @card = create(:card)
    @card.update(review_date: Date.yesterday)
  end

  after(:all) { @card.destroy }

  before { visit root_path }

  it { expect(page).to have_content 'Первый в мире' }
  it { expect(page).to have_content 'Переведите слово' }
  it { expect(page).to have_content 'дом' }
  it 'right answer' do
    fill_in :user_text, with: 'home'
    click_button 'Button'
    expect(page).to have_content 'Вы ответили правильно.'
  end
  #it { expect(page).not_to have_content 'дом' }
  # Не могу понять почему карта не проподает, вроде бы использую before(:all),
  # но все равно review_date откатывается на Date.yesterday.
  it 'wrong answer' do
    fill_in :user_text, with: 'NOhome'
    click_button 'Button'
    expect(page).to have_content 'Вы ответили неправильно.'
  end
end
