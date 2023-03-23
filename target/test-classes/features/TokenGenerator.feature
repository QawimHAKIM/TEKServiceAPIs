Feature: Token Generator

  @generateToken
  Scenario: Generate Token for tekRetail API tests
    Given url baseURL
    * path "/auth/login"
    * request {"email":"tester1234@outlook.com","password":"1234@Tester"}
    * method post
    * status 200
    * print response
