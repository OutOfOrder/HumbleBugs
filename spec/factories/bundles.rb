# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bundle do
    name "MyString"
    target_date "2012-01-25 10:12:56"
    description "MyText"
    state "MyString"
  end
end