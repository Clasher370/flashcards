require 'rails_helper'

describe SendNotificationMailToUser do
  before { create(:card) }

  it 'sends an email' do
    expect { described_class.run }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
