Feature: Show a list of items on loan
    As a registered user of the website
    I want to how many loans I have out
    And how many items I have borrowed
    So that I can manage the items out on loan and the items I have borrowed.
    
      Scenario: I sign in and see a summary of the loans I have.
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
        And the loan counter should be 2

      Scenario: I sign in and go to the loans page.
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
        When I follow "Loans"
        Then I should see "me@me.com has Drill Press"

      Scenario: I sign in and go to the borrowings page.
        Given I am a user named "foo" with an email "user@test.com" and password "please"
        Given the following loans exist
            | user_id | item        | borrower_id |
            | 1       | Drill Press | 1           |
            | 1       | Fight Club  | 2           |
            | 2       | Test        | 3           |
        Given the following borrowers exist
            | id | email                   |
            | 1  | me@me.com               |
            | 2  | darren@codingintent.com |
            | 3  | user@test.com           |
        When I sign in as "user@test.com/please"
        Then I should be signed in
        When I follow "Borrowing"
        Then I should see "You have something"
