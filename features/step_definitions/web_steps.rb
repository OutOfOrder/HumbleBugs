Then /^I should see a header with content "([^"]*)"$/ do |text|
  page.should have_css('h1', text: text)
end

Then /^I should see a field named "([^"]*)"$/ do |id|
  page.should have_field(id)
end

Then /^I should see a button named "([^"]*)"$/ do |text|
  page.should have_button(text)
end

When /^I go to the (.+) page$/ do |page|
  method = page.underscore.gsub(' ','_') + "_path"
  path = send(method)
  visit(path)
end

Then /^show me the page/ do
  save_and_open_page
end

