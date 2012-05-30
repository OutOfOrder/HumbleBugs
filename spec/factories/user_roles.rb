# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_role do
    associaion :user
    role "guest"
  end
end
