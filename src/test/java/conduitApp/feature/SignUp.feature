Feature: Sign Up new user
  Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def timeValidator = read ('classpath:helpers/timeValidator.js')
    * def ramdomEmail = dataGenerator.getRandomEmail()
    * def ramdomUsername = dataGenerator.getRandomUsername()
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

  Scenario Outline: Validate Sign Uo error messages
    Given path 'users'
    And request
    """
    {
       "user": {
         "email": "<email>",
         "password": "<password>",
         "username": "<username>"
       }
    }
    """
    When method Post
    Then status 422
    And match response == <errorResponse>

    Examples:
      | email                    | password  | username                             | errorResponse                                                                      |
      | #(ramdomEmail)           | Karate123 | KarateUser123                        | {"errors":{"username":["has already been taken"]}}                                 |
      | kakashisensei34@test.com | Karate123 | #(ramdomUsername)                    | {"errors":{"email":["has already been taken"]}}                                    |
      | kakashisenseitest.com    | Karate123 | KarateUser1231                       | {"errors":{"email":["is invalid"]}}                                                |
      | kakashisensei@37test.com | Karate123 | KarateUser12311111111111111111111111 | {"errors":{"username":["is too long (maximum is 20 characters)"]}}                 |
      | #(ramdomEmail)           | 123       | #(ramdomUsername)                    | {"errors":{"password":["is too short (minimum is 8 characters)"]}}                 |
      |                          | 12311111  | KarateUser123112                     | {"errors":{"email":["can't be blank"]}}                                            |
      | #(ramdomEmail)           |           | #(ramdomUsername)                    | {"errors":{"password":["can't be blank"]}}                                         |
      | #(ramdomEmail)           | 123456789 |                                      | {"errors":{"username":["can't be blank","is too short (minimum is 1 character)"]}} |

