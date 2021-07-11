Feature: Hooks

    Background: hooks
#      * def result = callonce read('classpath:helpers/Dummy.feature')
#      * def username = result.username

      #after hooks
      * configure afterScenario = function(){ karate.call('classpath:helpers/Dummy.feature') }
      * configure afterFeature =
      """
      function(){
      karate.log('After Feature Text')
      }
      """

  Scenario: First scenario
    * print 'This is first scenario'
    
  Scenario: Second Scenario
    * print 'This is second scenario'