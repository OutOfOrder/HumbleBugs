# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :predefined_tag do
    sequence(:name) { |n| "platform #{n}"}
    context "platforms"
  end
end
