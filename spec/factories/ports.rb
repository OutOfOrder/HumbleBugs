# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :port do
    game nil
    porter nil
    state "MyString"
  end
end
