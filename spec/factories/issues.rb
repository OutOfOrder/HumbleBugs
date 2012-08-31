# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    association :game
    association :author, :factory => :user
    summary "Issue Summary"
    description "Issue Description"
    status "new"

    trait :new do
      author nil
      game nil
    end
  end
end
