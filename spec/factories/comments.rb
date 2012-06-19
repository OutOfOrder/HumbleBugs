# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    comment "MyText"
    association :author, :factory => :user
    association :commentable, :factory => :issue
  end
end
