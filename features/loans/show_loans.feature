Feature: Show a list of items on loan
    As a registered user of the website
    I want to how many loans I have out
    So that I know how many things I have out on loan.
    
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
