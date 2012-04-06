Feature: Show a list of items on loan
    As a registered user of the website
    I want to see the items I have loaned out
    So that I know which items have been lent.
    
      Scenario: I sign in and see a list of items lent out.
        Given I am a user named "foo" with an email "user@test.com" and password "please"
        Given the following loans exist
            | user_id | item        | borrower_id |
            | 1       | Drill Press | 1           |
            | 1       | Fight Club  | 2           |
        Given the following borrowers exist
            | id | email                   |
            | 1  | me@me.com               |
            | 2  | darren@codingintent.com |
        When I sign in as "user@test.com/please"
        Then I should be signed in
        Then I should see "me@me.com has Drill Press"
        Then I should see "darren@codingintent.com has Fight Club"
