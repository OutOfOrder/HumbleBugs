# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :developer do
    transient do
      users []
    end

    sequence(:name) { |n| "Dev Name #{n}" }
    website "http://www.gamedeveloper.com/"
    time_zone "EST"

    trait :contact do
      address "123 Nowhere"
      contact_information "555-1234"
    end

    trait :with_user do
      after(:create) do |developer|
        FactoryGirl.create(:user, developer:developer)
      end
    end

    after(:create) do |developer, evaluator|
      evaluator.users.each do |user|
        user.developer = developer
      end
    end
  end
end
