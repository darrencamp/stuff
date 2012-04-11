Feature: New Loan
	As a registered user of the website
	I want to create a new loan
	so that I can lend my stuff to another person
	
	  Scenario: I sign in and create a new loan
      	Given I am a user named "foo" with an email "user@test.com" and password "please"
      	When I sign in as "user@test.com/please"
      	Then I should be signed in
		When I fill in "borrower_email" with "you@email.com"
      	And I fill in "item_name" with "drill press"
      	And I press "Create Loan"
      	And I go to the homepage
      	Then I should see "you@email.com has drill press"