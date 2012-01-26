# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    name "Pong"
    description "Awesome Pong Game of the Future"
    state "prospective"
  end
end
