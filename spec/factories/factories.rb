FactoryGirl.define do
  factory :deck do
    sequence(:name) { |n| "name#{n}" }
    user
  end

  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password 'secret'
    password_confirmation 'secret'
  end

  factory :card do
    original_text 'home'
    translated_text 'дом'
    deck
  end
end
