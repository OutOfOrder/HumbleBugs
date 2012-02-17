# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :note do
    note "MyText"
    owner nil
    noteable nil
  end
end
