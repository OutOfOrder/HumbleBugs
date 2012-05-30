# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    ignore do
      roles ['guest']
    end
    sequence(:email) { |n| "user#{n}@example.com" }
    name "user name"
    password "test password"
    password_confirmation "test password"

    after_build do |user, evaluator|
      evaluator.roles.each { |m| user.roles.build(:role => m.to_s) }
    end
  end
end
