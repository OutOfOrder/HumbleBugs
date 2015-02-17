Then /^I should see (\d+) games in a list$/ do |count|
  expect(page).to have_css("table tr.game", :count => count.to_i)
end

When /^I submit a new game for bundle "([^"]+)"$/ do |bundle_name|
  bundle = Bundle.find_by_name bundle_name
  attrs = FactoryGirl.attributes_for :game
  attrs.each do |field, value|
    if field == :state
      select value.camelize, :from => 'game_'+field.to_s
    else
      fill_in 'game_'+field.to_s, :with => value
    end
  end
  page.select bundle.name, :from => 'game_bundle_id'
  click_button 'Create Game'
end