# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    association :game
    description "MyText"
    status "new"
  end
end
