
Feature: Articles
    Background: Define URL
      Given url apiUrl

    @regression
    Scenario: Create a new article
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Teste_01","description": "Karate 3","body": "Teste_01."}}
        When method Post
        And match response.article.title == 'Teste_01'
        Then status 200

    Scenario: Create and delete article
#        Create article
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Delete article","description": "Karate 3","body": "Teste_01."}}
        When method Post
#        And match response.article.title == 'Delete article'
        * def slugId = response.article.slug
        Then status 200
#    Get article
        Given params {limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete article'
#        Delete article
        Given path 'articles/' + slugId
        When method Delete
        Then status 200

#        Get article to verify delete
        Given params {limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete article'

