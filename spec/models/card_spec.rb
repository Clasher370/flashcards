require 'rails_helper'

RSpec.describe Card, type: :model do

  it 'valid' do
    expect(build(:card)).to be_valid
  end
end
