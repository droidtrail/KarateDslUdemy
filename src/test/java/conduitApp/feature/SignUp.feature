@ignore
Feature: Sign Up new user
  Background: Preconditions
    Given url apiUrl

  Scenario: New user Sign Up
    Given def userData = {"email":"karateLesson17_v5@test.com", "username":"karateLesson17_v5"}
    Given path 'users'
    And request
    """
    {
       "user": {
         "email": #(userData.email),
         "password": "12345678",
         "username": #(userData.username)
       }
    }
    """
    When method Post
    Then status 200