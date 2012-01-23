Given /^I am logged out$/ do
  pass
end

Given /^I am logged in as "([^"]+)"$/ do |email|
  page.cookies[:auth_token] = {
      value: User.find_by_email!(email).auth_token,
      httponly: true
  }
end

When /^I go to the signup page$/ do
  visit(signup_path)
end
