# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
[
    {context: 'platforms', name: 'Windows'},
    {context: 'platforms', name: 'Mac OS X'},
    {context: 'platforms', name: 'Linux x86'},
    {context: 'platforms', name: 'Linux x86_64'},
    {context: 'platforms', name: 'Android'}
].each do |o|
  PredefinedTag.find_or_create_by_context_and_name(o[:context], o[:name]);
end

if Rails.env.development?
  # load dummy users
  Authorization::Engine.instance.role_titles.each do |role, title|
    unless User.find_by_email("#{role.to_s}@example.com")
      u = User.create!(name: title, email: "#{role.to_s}@example.com", password: "test", password_confirmation: "test")
      u.roles.create! role: role.to_s
    end
  end

  developer = Developer.find_or_create_by_name!({name: 'Test Developer', time_zone: 'Pacific Time (US & Canada', address: '123 Nowhere', contact_information: '555-1234' }, without_protection: true)
  unless User.find_by_email("developer@example.com")
    u = User.create!({name: 'Developer', email: "developer@example.com", password: "test", password_confirmation: "test", developer: developer}, without_protection: true)
    u.roles.create! role: 'user'
  end

  # load dummy bundles and games
  if developer.games.empty?
    game_name = Faker::Product.product_name
    Game.create!(name: game_name, description: game_name, state: 'development', platform_list: 'Windows', developer: developer)
  end

  unless Bundle.find_by_name('Planned Bundle')
    Bundle.create!(name: 'Planned Bundle', state: 'planned', description: 'Planning bundle for testing').tap do |bundle|
      game_name = Faker::Product.product_name
      bundle.games.create!(name: game_name, description: game_name, state: 'prospective', platform_list: 'Windows')
    end
  end
  unless Bundle.find_by_name('In Development Bundle')
    Bundle.create!(name: 'In Development Bundle', state: 'development', description: 'In development').tap do |bundle|
      game_name = Faker::Product.product_name
      bundle.games.create!(name: game_name, description: game_name, state: 'development', platform_list: 'Windows').tap do |game|
        game.ports.create!(porter: User.find_by_email('porter@example.com'), state: 'development', platform_list: 'Linux x86,Mac OS X')
      end
      game_name = Faker::Product.product_name
      bundle.games.create!(name: game_name, description: game_name, state: 'planned', platform_list: 'Windows,Mac OS X').tap do |game|
        game.ports.create!(porter: User.find_by_email('porter@example.com'), state: 'development', platform_list: 'Linux x86')
      end
    end
  end
  unless Bundle.find_by_name('Pending Release Bundle')
    Bundle.create!(name: 'Pending Release Bundle', state: 'pending', description: 'Ready to go waiting for target date', target_date: 3.weeks.from_now).tap do |bundle|
      game_name = Faker::Product.product_name
      bundle.games.create!(name: game_name, description: game_name, state: 'testing', platform_list: 'Windows,Mac OS X,Linux x86,Linux x86_64')
      game_name = Faker::Product.product_name
      bundle.games.create!(name: game_name, description: game_name, state: 'testing', platform_list: 'Windows').tap do |game|
        game.ports.create!(porter: User.find_by_email('porter@example.com'), state: 'development', platform_list: 'Linux x86,Mac OS X')
      end
    end
  end
  unless Bundle.find_by_name('Active Bundle')
    Bundle.create!(name: 'Active Bundle', state: 'active', description: 'Live and selling like hotcakes', target_date: 2.days.ago).tap do |bundle|
      game_name = Faker::Product.product_name
      bundle.games.create!(name: game_name, description: game_name, state: 'completed', platform_list: 'Windows,Mac OS X,Linux x86,Linux x86_64')
    end
  end
  unless Bundle.find_by_name('Past Bundle')
    Bundle.create!('Past Bundle', state: 'completed', description: 'In the past and completed', target_date: 4.weeks.ago).tap do |bundle|
      game_name = Faker::Product.product_name
      bundle.games.create!(name: game_name, description: game_name, state: 'completed', platform_list: 'Windows,Mac OS X,Linux x86,Linux x86_64')
    end
  end
end
