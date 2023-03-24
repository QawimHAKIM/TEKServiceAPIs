@payment
Feature: TEk Retail Payment Service

  Background: 
    * url baseURL
    * def tokenValue = call read("TokenGenerator.feature")
    * def token = tokenValue.response.accessToken
    * header x-access-token = token

  @payment1
  Scenario: Get Payment Service Test
    * path "/payment"
    * method get
    * status 200
    * print response[0].id
    * def id = response[0].id
    * def dbUtility = Java.type("test.DBUtility")
    * def dbCardNumber = dbUtility.result("select cardNumber from payments where id = '"+id+"'", "cardNumber")
    * def responseCard = response[0].cardNumber
    * match responseCard == dbCardNumber
    * print responseCard
    * print dbCardNumber
    * print response

  @payment2
  Scenario: Post Payment Service Test
    * path "/payment"
    * def card = "1234567891234564"
    * def name = "JohnTester"
    * def expireM = 12
    * def expireY = 2025
    * def sCode = "123"
    * request
      """
      {
      "cardNumber": "#(card)",
      "nameOnCard": "#(name)",
      "expirationMonth": "#(expireM)",
      "expirationYear": "#(expireY)",
      "securityCode": "#(sCode)"
      }
      """
    * method post
    * status 200
    * print response

  @payment3
  Scenario: Put Payment Service Test
    * def id = 5304
    * path "/payment/" + id
    * request {"expirationMonth":9,"expirationYear":2027}
    * method put
    * status 200
    * match responseType == 'json'
    * assert responseTime < 1000
    * print response

  @payment4
  Scenario: Delete Payment Service Test
    * def id = 5304
    * path "/payment/" + id
    * method delete
    * status 200
    * print response
