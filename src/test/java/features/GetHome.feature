Feature: TEK Retail Home Service

  @home
  Scenario: Get Home Service Test
    Given url baseURL
    * def tokenValue = call read("TokenGenerator.feature")
    * def token = tokenValue.response.accessToken
    * header x-access-token = token
    * path "/home"
    * method get
    * status 200
    * print response
