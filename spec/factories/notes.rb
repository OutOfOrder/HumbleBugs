# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    note "MyText"
    association :owner, :factory => :user
    association :noteable, :factory => :issue
  end
end
