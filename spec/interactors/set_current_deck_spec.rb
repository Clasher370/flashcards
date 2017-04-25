require 'rails_helper'

describe SetCurrentDeck do
  let(:deck) { create(:deck) }

  context 'current' do
    before { @params = { id: deck.id } }

    context 'set and unset' do
      before { @set_deck = SetCurrentDeck.call(@params) }

      it { expect(@set_deck.notice).to eq "Текущая колода #{deck.name}" }

      it 'unset' do
        set_deck = SetCurrentDeck.call(@params)
        expect(set_deck.notice).to eq 'Нет текущих колод'
      end
    end
  end
end
