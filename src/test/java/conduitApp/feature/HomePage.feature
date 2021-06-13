Feature: Tests for the home page
    Background: Define URL
        Given url apiUrl

    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['Gandhi','HITLER']
        And match response.tags !contains 'casa'
        And match response.tags contains any ['fish', 'dog', 'SIDA']
        And match response.tags =="#array"
        And match each response.tags =="#string"
    @regression
    Scenario: Get 10 articles from page
        Given params {limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles == '#[10]'
        And match response.articlesCount == 500

