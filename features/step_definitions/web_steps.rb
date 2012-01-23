Then /^I should see a header with content "([^"]*)"$/ do |text|
  page.should have_css('h1', text: text)
end

Then /^I should see a field named "([^"]*)"$/ do |id|
  page.should have_field(id)
end

Then /^I should see a button named "([^"]*)"$/ do |text|
  page.should have_button(text)
end