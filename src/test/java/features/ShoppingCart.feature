Feature: Shopping Cart Services

  Background: 
    Given url baseURL
    * def tokenValue = call read("TokenGenerator.feature")
    * def token = tokenValue.response.accessToken
    * header x-access-token = token

  @cart1
  Scenario: Get Shopping Cart Service Test
    * path "/shopping-cart"
    * def buyerID = tokenValue.response.roleId
    * param buyerId = buyerID
    * method get
    * status 200
    * def id = response.buyerId
    * match buyerID == 3862
    * print response

		@cart2
    Scenario: Post to Shopping Cart Service Test
    * path "/shopping-cart"
    * request {"productId":4,"quantity":3}
    * method post
    * status 200
    * print response
    
    @cart3
    Scenario: Update of Shopping Cart Service Test
    * def id = 5554
    * path "/shopping-cart/" + id 
    * request {"quantity":8}
    * method patch
    * print response
    
    @cart4
    Scenario: Delete From Shopping Cart Service Test
    * def id = 5553
    * path "/shopping-cart/" + id
    * method delete
    * status 200
    * print response
    
    
    
    
    
    
    
    