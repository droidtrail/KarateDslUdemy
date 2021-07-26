Feature: work with DB

  Background: connect to db
      * def DbHandler = Java.type('helpers.DbHandler')

  Scenario: Seed database with a new Job
    *eval DbHandler.addNewJobWithName("Qa2")
