Then /^I should see (\d+) games in a list$/ do |count|
  page.should have_css("table tr.game", :count => count.to_i)
end

When /^I submit a new game for bundle "([^"]+)"$/ do |bundle_name|
  bundle = Bundle.find_by_name bundle_name
  attrs = FactoryGirl.attributes_for :game
  attrs.each do |field, value|
    fill_in 'game_'+field.to_s, :with => value
  end
  page.select bundle.name, :from => 'game_bundle_id'
  click_button 'submit_game'
end