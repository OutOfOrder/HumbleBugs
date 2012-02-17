# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :release do
    notes "MyText"
    owner nil
    game nil
    url "MyString"
  end
end
