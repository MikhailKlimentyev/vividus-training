GivenStories: story/demo/Homepage_Demo.story

Scenario: Log in as a Good User
When I enter `${swagGoodUserName}` in field located by `By.CssSelector(#user-name)`
And I enter `${swagPassword}` in field located by `By.CssSelector(#password)`
And I click on element located `By.CssSelector(#login-button)`
Then the page with the URL 'https://www.saucedemo.com/inventory.html' is loaded
And number of elements found by `By.CssSelector(.inventory_item)` is equal to `6`
When I take screenshot