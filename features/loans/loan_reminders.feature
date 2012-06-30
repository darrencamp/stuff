Feature: Loan Reminders
      As a registered user of the website
      I want to send reminders to borrowers
      so that they remember that they have loaned my stuff

        Scenario: I click the remind button
            Given I am a user named "foo" with an email "user@test.com" and password "please"
            Given the following loans exist
                  | user_id | item | borrower_id   |
                  | 1       | test | 1             |
            Given the following borrowers exist
                  | id | email     |
                  | 1  | me@me.com |
            When I sign in as "user@test.com/please"
            Then I should be signed in
            Then I should see "me@me.com has test"
            When I press "Remind"
            Then me@me.com should receive an email