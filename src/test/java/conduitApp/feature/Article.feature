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
