# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    transient do
      roles []
    end
    sequence(:email) { |n| "user#{n}@example.com" }
    name "user name"
    password "t3stpassword"
    password_confirmation "t3stpassword"

    trait :password_reset do
      password_reset_token { SecureRandom.urlsafe_base64 }
      password_reset_sent_at { Time.now }
    end

    trait :confirm_account do
      confirm_account_token { SecureRandom.urlsafe_base64 }
      confirm_account_sent_at { Time.now }
    end

    trait :signed_nda do
      nda_signed_date { Time.now }
    end

    trait :with_developer do
      developer
    end

    trait :confirmed do
      roles ['user']
	    confirm_account_token nil
      confirm_account_sent_at { Time.now }
    end

    after(:build) do |user, evaluator|
      evaluator.roles.each { |m| user.roles.build(:role => m.to_s) }
    end
  end
end
