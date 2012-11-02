# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    bundle
    name "Pong"
    description "Awesome Pong Game of the Future"
    state "prospective"

    trait :testing do
      state "testing"
    end

    ignore do
      developer_users []
    end

    after(:build) do |game, evaluator|
      if evaluator.developer_users.present?
        game.developer = FactoryGirl.create :developer, users:developer_users
      end
    end

    trait :with_developer do
      association :developer, :with_user
    end

    trait :with_active_bundle do
      bundle { FactoryGirl.build :bundle, :active }
    end
  end
end
