# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :release do
    notes "MyText"
    association :owner, :factory => :user
    association :game
    status 'active'
    url "http://www.example.com/awesomeGame.zip"
    version { FFaker::Product.letters(4) }
  end
end
