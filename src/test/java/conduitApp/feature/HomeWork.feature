Feature: Home Work
  Background: Preconditions
    * url apiUrl
    * def timeValidator = read ('classpath:helpers/timeValidator.js')

    Scenario: Get Favorite articles
      #Step 1: Get articles of the global feed
      Given params {limit: 10, offset: 0 }
      Given path 'articles'
      When method Get
      Then status 200
      # Step 2: Get the favorites count and slug ID for the first arice, save it to variables
      * def slugID = response.articles[0].slug
      * def favoritesCountNumber = response.articles[0].favoritesCount
      # Step 3: Make POST request to increse favorites count for the first article
      Given path 'articles/'+slugID+'/favorite'
      And request {}
      When method Post
      Then status 200
      * print response.article
#      # Step 4: Verify response schema
      And match response.articles ==
"""
        {
  "tagList": [
  ],
  "createdAt": "#? timeValidator(_)",
  "author": {
    "image": "#string",
    "following": #boolean,
    "bio": #string,
    "username": "#string"
  },
  "description": "#string",
  "title": "#string",
  "body": "#string",
  "favoritesCount": #number,
  "slug": "#string",
  "updatedAt": "#? timeValidator(_)",
  "favorited": #boolean
}

"""
