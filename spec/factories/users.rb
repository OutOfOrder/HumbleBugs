# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    ignore do
      roles []
    end
    sequence(:email) { |n| "user#{n}@example.com" }
    name "user name"
    password "test password"
    password_confirmation "test password"

    trait :password_reset do
      password_reset_token { SecureRandom.urlsafe_base64 }
      password_reset_sent_at { Time.now }
    end

    trait :confirm_account do
      confirm_account_token { SecureRandom.urlsafe_base64 }
      confirm_account_sent_at { Time.now }
    end

    after(:build) do |user, evaluator|
      evaluator.roles.each { |m| user.roles.build(:role => m.to_s) }
    end
  end
end
