require 'rails_helper'

RSpec.describe Deck, type: :model do
  it 'invalid without name' do
    deck = build(:deck)
    expect(deck).to be_valid
  end
end
