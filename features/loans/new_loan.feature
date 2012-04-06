Feature: New Loan
	As a registered user of the website
	I want to create a new loan
	so that I can lend my stuff to another person
	
	  Scenario: I sign in and create a new loan
      	Given I am a user named "foo" with an email "user@test.com" and password "please"
      	When I sign in as "user@test.com/please"
      	Then I should be signed in
      	When I follow "New loan."
		And I fill in "Email" with "you@email.com"
      	And I fill in "Item" with "drill press"
      	And I press "Create"
      	And I go to the homepage
      	Then I should see "you@email.com has drill press"