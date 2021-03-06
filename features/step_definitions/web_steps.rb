Then /^I should see a field named "([^"]*)"$/ do |id|
  expect(page).to have_field(id)
end

Then /^I should see a button named "([^"]*)"$/ do |text|
  expect(page).to have_button(text)
end

When /^I go to the (.+) page$/ do |page|
  method = page.underscore.gsub(' ','_') + "_path"
  path = send(method)
  visit(path)
end

Then /^show me the page/ do
  save_and_open_page
end

