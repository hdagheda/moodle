@core @javascript
Feature: Notify user "No recent activity"
  And allow user to extend session
  Or inform user about session expired

  Scenario: Extend session
    Given the following config values are set as admin:
      | sessiontimeout        | 20 |
      | sessiontimeoutwarning | 5  |

    And I log in as "admin"
    When I wait "16" seconds
    Then "No recent activity" "dialogue" should be visible
    And I click on "Extend session" "button"
    And "No recent activity" "dialogue" should not be visible

  Scenario: Cancel notification
    Given the following config values are set as admin:
      | sessiontimeout        | 20 |
      | sessiontimeoutwarning | 5  |

    And I log in as "admin"
    When I wait "16" seconds
    Then "No recent activity" "dialogue" should be visible
    And I click on "Cancel" "button" in the "No recent activity" "dialogue"
    And "No recent activity" "dialogue" should not be visible

  Scenario: Session expired
    Given the following config values are set as admin:
      | sessiontimeout        | 20 |
      | sessiontimeoutwarning | 5  |

    And I log in as "admin"
    When I wait "16" seconds
    Then "No recent activity" "dialogue" should be visible
    And I wait "4" seconds
    And "No recent activity" "dialogue" should not be visible
    And "Session expired" "dialogue" should be visible

  Scenario: Log in again
    Given the following config values are set as admin:
      | sessiontimeout        | 20 |
      | sessiontimeoutwarning | 5  |
    And I log in as "admin"
    When I wait "16" seconds
    Then "No recent activity" "dialogue" should be visible
    And I wait "4" seconds
    And "No recent activity" "dialogue" should not be visible
    And "Session expired" "dialogue" should be visible
    And I click on "Log in again" "button"
    And I should see "Your session has timed out. Please log in again."

  Scenario: Extend session in two tabs
    Given the following config values are set as admin:
      | sessiontimeout        | 20 |
      | sessiontimeoutwarning | 5  |
    And I log in as "admin"
    And I am on course index
    When I open a new window at "/my"
    And I switch to the previous window
    And I wait "16" seconds
    And "No recent activity" "dialogue" should be visible
    And I click on "Extend session" "button"
    And "No recent activity" "dialogue" should not be visible
    And I switch to the next window
    Then "No recent activity" "dialogue" should not be visible
    And I click on "Site home" "link"
    And I should see "You are logged in as"
