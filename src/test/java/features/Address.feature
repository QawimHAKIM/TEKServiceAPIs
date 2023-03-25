@address
Feature: TEK Retail Addresses Service

  Background: 
    Given url baseURL
    * def tokenValue = call read("TokenGenerator.feature")
    * def token = tokenValue.response.accessToken
    * header x-access-token = token

  @address1
  Scenario: Get Address Service Test
    * path "/address"
    * method get
    * status 200
    * print response

  @address2
  Scenario: Post Address Service Test
    * path "/address"
    * request
      """
      {
      "country": "Egypt",
      "fullName": "Jack",
      "phoneNumber": "98765432112",
      "street": "123Hello",
      "apartment": "123",
      "city": "Tysons",
      "state": "California",
      "zipCode": "45678"
      }
      """
    * method post
    * print response

  @address3
  Scenario: Update Address Service Test
    * def dbUtility = Java.type("test.DBUtility")
    * def name = "Jack"
    * def id = dbUtility.result("select id from addresses where fullName = '" + name + "'", "id")
    * path "/address/" + id
    * request {"country":"Dubai","fullName":"DubaiDubai"}
    * method put
    * status 200
    * print response

  @address4
  Scenario: Delete Address Service Test
    * def dbUtility = Java.type("test.DBUtility")
    * def name = "DubaiDubai"
    * def id = dbUtility.result("select id from addresses where fullName = '" + name + "'", "id")
    * path "/address/" + id
    * method delete
    * status 200
    * print response
