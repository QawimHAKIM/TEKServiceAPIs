@schema
Feature: TEK Retail API Schema Validation

  Background: 
    Given url baseURL
    * def tokenValue = call read("TokenGenerator.feature")
    * def token = tokenValue.response.accessToken
    * def id = tokenValue.response.roleId
    * header x-access-token = token

  @addressSchema
  Scenario: Address API Schema Validation
    * path "/address"
    * method get
    * print response
    * match response contains any
      """
      [
      {
          "id": '#number',
          "country": '#string',
          "fullName": '#string',
          "phoneNumber": '#string',
          "street": '#string',
          "apartment": '#string',
          "city": '#string',
          "state": '#string',
          "zipCode": '#number',
          "userId": '#number',
          "isDeleted": '#present',
          "createdAt": '#present',
          "updatedAt": '#present'
        }
      ]       
      """
    * match responseType == 'json'
    * assert responseTime < 1000

  @shoppingSchema
  Scenario: Shopping Cart API Schema Validation
    * path "/shopping-cart"
    * param buyerId = id
    * method get
    * match response contains any
      """
      [
      {
      "id": '#number',
      "productId": '#number',
      "price": '#number',
      "quantity": '#number',
      "buyerId":'#number',
      "productName": '#string',
      "productImageUrl": '#string'
      }
      ]

      """
    * match responseType == 'json'
    * assert responseTime < 500

  @paymentSchema
  Scenario: Payment API Schema Validation
    * path "/payment"
    * method get
    * match response contains any
      """
      [
      {
      "id": '#number',
      "cardNumber": '#string',
      "nameOnCard": '#string',
      "expirationMonth": '#number',
      "expirationYear": '#number',
      "securityCode": '#number',
      "userId": '#number',
      "isDeleted": '#present',
      "createdAt": '#present',
      "updatedAt": '#present'
      }
      ]
      """
    * match responseType == 'json'
    * match responseType != 'xml'
    * assert responseTime < 300
