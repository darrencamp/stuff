Scenario: Visiting the home for the first time
  Given I am a new user
	When I sign in for the first time
	Then I should see a welcome message
	And I should see some explanatory text for what to do next 