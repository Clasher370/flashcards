require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context 'valid' do
    it { expect(user).to be_valid }
    it { expect(user.cards).to_not be_nil }
  end

  context 'invalid without' do
    it 'email' do
      user.email = ''
      expect(user).not_to be_valid
    end

    it 'password' do
      user.password = ''
      expect(user).not_to be_valid
    end

    it 'normal size password' do
      user.password = '12'
      expect(user).not_to be_valid
    end

    context 'correct email, when' do
      it 'no domen' do
        user.email = 'user@mail'
        expect(user).not_to be_valid
      end
      it 'no it' do
        user.email = 'usermail.ru'
        expect(user).not_to be_valid
      end
      it 'no name' do
        user.email = '@mail.ru'
        expect(user).not_to be_valid
      end
      it 'no it and domen' do
        user.email = 'usermail.ru'
        expect(user).not_to be_valid
      end
      it 'with unnecessary dots' do
        user.email = 'user@email.r.u'
        expect(user).not_to be_valid
      end
    end
  end
end
