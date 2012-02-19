# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :port do
    association :game
    association :porter, :factory => :user
    state "MyString"
  end
end
