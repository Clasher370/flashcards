require 'rails_helper'

describe CardsMailer do
  let(:user) { create(:user) }
  let(:mail) { described_class.pending_cards_notification(user).deliver_now }

  it 'renders the subject' do
    expect(mail.subject).to eq('Пора проверять карты!')
  end

  it 'renders the receiver email' do
    expect(mail.to).to eq([user.email])
  end

  it 'renders the sender email' do
    expect(mail.from).to eq(['notifications@example.com'])
  end
end
