Feature: Articles
  Background: Define URL
    * url apiUrl
    * def articleRequestBody = read('classpath:conduitApp/json/newArticleRequest.json')
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def generatedArticleValues = dataGenerator.getRandomArticleValues()
    * set articleRequestBody.article.title = __gatling.Title
    * set articleRequestBody.article.description = __gatling.Description
    * set articleRequestBody.article.body = generatedArticleValues.body

    * def sleep = function(ms){java.lang.Thread.sleep(ms)}
    * def pause = karate.get('_gatling.pause',sleep)

  Scenario: Create and delete article
#        Create article
    Given path 'articles'
    And request articleRequestBody
    When method Post
    Then status 200
    * def slugId = response.article.slug


#    Given path 'articles/' + slugId
#    When method Delete
#    Then status 200



