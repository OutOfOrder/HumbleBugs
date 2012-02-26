# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :predefined_tag do
    name "My Platform"
    context "platforms"
  end
end
