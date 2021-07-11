Feature: Articles
    Background: Define URL
      * url apiUrl
      * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
      * def dataGenerator = Java.type('helpers.DataGenerator')
      * def generatedArticleValues = dataGenerator.getRandomArticleValues()
      * set articleRequestBody.article.title = generatedArticleValues.title
      * set articleRequestBody.article.description = generatedArticleValues.description
      * set articleRequestBody.article.body = generatedArticleValues.body

    @regression
    Scenario: Create a new article
        Given path 'articles'
        And request articleRequestBody
        When method Post
      * print articleRequestBody.article.title
        And match response.article.title == articleRequestBody.article.title
        Then status 200

    Scenario: Create and delete article
#        Create article
        Given path 'articles'
        And request articleRequestBody
        When method Post
        * def slugId = response.article.slug
        Then status 200
#    Get article
        Given params {limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == articleRequestBody.article.title
#        Delete article
        Given path 'articles/' + slugId
        When method Delete
        Then status 200
#        Get article to verify delete
        Given params {limit: 10, offset: 0 }
        Given path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title

