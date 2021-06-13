Feature: Articles
    Background: Define URL
        * url apiUrl
        Given path 'users/login'
        And request {"user": {"email": "kakashisensei@test.com","password": "12345678"}}
        Then method Post
        Then status 200
        * def token = response.user.token
    @regression
    Scenario: Create a new article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Teste_01","description": "Karate 3","body": "Teste_01."}}
        When method Post
        And match response.article.title == 'Teste_01'
        Then status 200
    @debug
    Scenario: Create and delete article
#        Create article
        Given header Authorization = 'Token ' + token
        Given path 'articles'
        And request {"article": {"tagList": [],"title": "Delete article","description": "Karate 3","body": "Teste_01."}}
        When method Post
        And match response.article.title == 'Delete article'
        * def slugId = response.article.slug
        Then status 200
#    Get article
        Given params {limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == 'Delete article'
#        Delete article
        Given header Authorization = 'Token ' + token
        Given path 'articles/' + slugId
        When method Delete
        Then status 200

#        Get article to verify delete
        Given params {limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != 'Delete article'

