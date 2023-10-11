Meta:
    @group Training
    @requirementId MyTask-0007


Scenario: Navigate to the website homepage
When I open Main application page

Scenario: Log In
When I Log in as a User with ${swagGoodUserName} and ${swagPassword}

Scenario: Add item to the shopping cart
When I go to relative URL `/inventory.html`
When I click on element located by `By.xpath(//*[contains(text(), '<itemName>')])`
Then the page with the URL containing '<itemPageId>' is loaded
When I click on element located by `By.id(<addToCartButtonId>)`
Examples:
| addToCartButtonId	                            | itemName                          | itemPageId                |
| add-to-cart-sauce-labs-backpack               | Sauce Labs Backpack               | /inventory-item.html?id=4 |

Scenario: Populate checkout data
When I click on element located by `By.id(shopping_cart_container)`
When I click on element located by `By.id(checkout)`
When I enter `#{generate(Name.firstName)}` in field located by `By.id(first-name)`
When I enter `#{generate(regexify '[A-Z]{10}')}` in field located by `By.id(last-name)`
When I enter `#{generate(regexify '[A-Z]{3}-\d{5}')}` in field located by `By.id(postal-code)`
When I take screenshot

Scenario: Complete checkout process
When I click on element located by `By.id(continue)`
When I click on element located by `By.id(finish)`
When I change context to element located by `By.cssSelector(.complete-header)`
When I save text of context element to scenario variable `thankYouMessageScreen`
Given I initialize scenario variable `thankYouMessageContents` with value `#{loadResource(/data/message.txt)}`
Then `${thankYouMessageScreen}` is equal to `${thankYouMessageContents}` 
Then `#{eval(`${thankYouMessageScreen}` == `${thankYouMessageContents}`)}` is equal to `true`
When I take screenshot