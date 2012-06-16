# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    association :bundle
    name "Pong"
    description "Awesome Pong Game of the Future"
    state "prospective"

    trait :testing do
      state "testing"
    end
  end
end
