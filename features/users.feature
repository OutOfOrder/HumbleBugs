Feature: Users
  Basic user authentication

  Scenario: Sign up for a user account
    Given I am logged out
    When I go to the signup page
    Then I should see a header with content "Sign Up"
    And I should see a field named "user_email"
    And I should see a field named "user_name"
    And I should see a field named "user_password"
    And I should see a field named "user_password_confirmation"
    And I should see a button named "Sign Up"