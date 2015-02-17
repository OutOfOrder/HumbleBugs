Given /^an? (.*?) "(.*?)" Bundle exists$/ do |state, name|
  FactoryGirl.create :bundle, state.to_sym, :name => name
end

Given /^the Bundle "([^"]*)" has the following games$/ do |bundle_name, table|
  bundle = Bundle.find_by_name bundle_name

  table.hashes.each do |hash|
    FactoryGirl.create :game, hash.merge(:bundle => bundle)
  end
end

When /^I go to the (.+) page for the Bundle named "([^"]*)"$/ do |page, name|
  bundle = Bundle.find_by_name(name)
  method = page.underscore.gsub(' ','_') + '_path'
  path = send(method, bundle)
  visit(path)
end

Then /^I should have (\d+) game for bundle "([^"]+)"/ do |count, name|
  bundle = Bundle.find_by_name(name)
  expect(bundle.games.count).to eq(count.to_i)
end