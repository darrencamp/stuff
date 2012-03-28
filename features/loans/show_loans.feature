Feature: Show a list of items on loan
    As a registered user of the website
    I want to see the items I have loaned out
    So that I know which items have been lent.
    
      Scenario: I sign in and see a list of items lent out.
        Given I am a user named "foo" with an email "user@test.com" and password "please"
        Given the following loans exist
            | user_id | item        | contact                 |
            | 1       | Drill Press | me@me.com               |
            | 1       | Fight Club  | darren@codingintent.com |
        When I sign in as "user@test.com/please"
        Then I should be signed in
        Then I should see "me@me.com has Drill Press"
        Then I should see "darren@codingintent.com has Fight Club"
