Feature: Sign up
  In order to get access to protected sections of the site
  As a user
  I want to be able to sign up

    Background:
      Given I am not logged in
      And I am on the home page
      And I go to the sign up page

    Scenario: User signs up with valid data
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_email                 | user@test.com   |
        | user_password              | please          |
        | user_password_confirmation | please          |
      And I press "sign_up"
      Then I should see "A message with a confirmation link has been sent to your email address" 
      And I should receive a confirmation email
      
    Scenario: User signs up with invalid email
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_email                 | invalidemail    |
        | user_password              | please          |
        | user_password_confirmation | please          |
      And I press "Sign up"
      Then I should see "Email is invalid"

    Scenario: User signs up without password
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_email                 | user@test.com   |
        | user_password              |                 |
        | user_password_confirmation | please          |
      And I press "Sign up"
      Then I should see "Password can't be blank"

    Scenario: User signs up without password confirmation
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_email                 | user@test.com   |
        | user_password              | please          |
        | user_password_confirmation |                 |
      And I press "Sign up"
      Then I should see "Password doesn't match confirmation"

    Scenario: User signs up with mismatched password and confirmation
      And I fill in the following:
        | user_name                  | Testy McUserton |
        | user_email                 | user@test.com   |
        | user_password              | please          |
        | user_password_confirmation | please1         |
      And I press "Sign up"
      Then I should see "Password doesn't match confirmation"

