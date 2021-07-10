
Feature: Sign Up new user
  Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read ('classpath:helpers/timeValidator.js')
    Given url apiUrl
@debug
  Scenario: New user Sign Up
    * def ramdomEmail = dataGenerator.getRandomEmail()
    * def ramdomUsername = dataGenerator.getRandomUsername()
    Given path 'users'
    And request
    """
    {
       "user": {
         "email": #(ramdomEmail),
         "password": "12345678",
         "username": #(ramdomUsername)
       }
    }
    """
    When method Post
    Then status 200
And match response ==
    """
        {
           "user": {
                "id": "#number",
                "email": #(ramdomEmail),
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "username": #(ramdomUsername),
                "bio": null,
                "image": null,
                "token": "#string"
           }
        }
    """