FactoryGirl.define do
  factory :deck do
    sequence(:name) { |n| "name#{n}" }
    user
  end

  factory :user do
    sequence(:email) { |n| "email#{n}@example.com" }
    password 'secret'
    password_confirmation 'secret'

    factory :user_with_decks do
      transient do
        decks_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:deck, evaluator.decks_count, user: user)
      end
    end
  end

  factory :card do
    original_text 'home'
    translated_text 'дом'
    deck
  end
end
