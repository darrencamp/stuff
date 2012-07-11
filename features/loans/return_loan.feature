Feature: A loaned item is returned
    As a registered user of the website
    I want to mark an item as returned
    So that I can know which items are still loaned out
    
      Scenario: I sign in and mark a loan as returned
        Given I am a user named "foo" with an email "user@test.com" and password "please"
        Given the following loans exist
            | user_id | item | borrower_id   |
            | 1       | test | 1             |
        Given the following borrowers exist
            | id | email     |
            | 1  | me@me.com |
        When I sign in as "user@test.com/please"
        Then I should be signed in
        And the loan counter should be 1
        When I follow "Loans"
        Then I should see "me@me.com has test"
        When I press "Return loan."
        Then I should not see "darren has test" 