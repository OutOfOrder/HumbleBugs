# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :release do
    notes "MyText"
    association :owner, :factory => :user
    association :game
    url "MyString"
  end
end
