Feature: A loaned item is returned
    As a registered user of the website
    I want to mark an item as returned
    So that I can know which items are still loaned out
    
      Scenario: I sign in and mark a loan as returned
        Given I am a user named "foo" with an email "user@test.com" and password "please"
        Given the following loans exist
            | user_id | item | contact   | person |
            | 1       | test | me@me.com | darren |
        When I sign in as "user@test.com/please"
        Then I should be signed in
        Then I should see "darren has test"
        When I press "Return loan."
        Then I should not see "darren has test" 