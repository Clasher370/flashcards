require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context 'valid' do
    it { expect(user).to be_valid }
    it { expect(user.cards).to_not be_nil }
  end

  context 'invalid' do
    it 'without email' do
      user.email = ''
      expect(user).not_to be_valid
    end

    it 'without password' do
      user.password = ''
      expect(user).not_to be_valid
    end

    it 'with short password' do
      user.password = '12'
      expect(user).not_to be_valid
    end
  end
end
