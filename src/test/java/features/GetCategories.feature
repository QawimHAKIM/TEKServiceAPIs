Feature: Get categories of TEK Retail

  @getCategories
  Scenario: Get Categories API Service Test
    * url baseURL
    * def tokenValue = call read("TokenGenerator.feature")
    * def token = tokenValue.response.accessToken
    * header x-access-token = token
    * path "/category"
    * method get
    * status 200
    * print response
