Feature: Games
  In order to manage tracking of porting bugs with games
  We need to track each game for a bundle

  Scenario: List Games
    Given I am logged in as admin User
    Given an active "Cucumber" Bundle exists
    And the Bundle "Cucumber" has the following games
      |name   |
      |Pong   |
      |Pacman |
      |Doom   |
    When I go to the Bundle games page for the Bundle named "Cucumber"
    Then I should see 3 games in a list

  Scenario: Add a game
    Given I am logged in as admin User
    Given a planned "Cucumber" Bundle exists
    When I go to the new Game page
    And I submit a new game for bundle "Cucumber"
    Then I should have 1 game for bundle "Cucumber"
