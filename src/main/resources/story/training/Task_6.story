Meta:
    @group Training
    @requirementId MyTask-0006

Lifecycle:
Examples:
|userName	            |password	        |
|${swagGoodUserName}	|${swagPassword}	|
|${swagSlowUserName}	|${swagPassword}	|

Scenario: Navigate to the website homepage
When I open Main application page

Scenario: Log In
When I Log in as a User with <userName> and <password>

Scenario: Add item to the shopping cart
When I go to relative URL `/inventory.html`
When I click on element located by `By.xpath(//*[contains(text(), '<itemName>')])`
Then the page with the URL containing '<itemPageId>' is loaded
When I click on element located by `By.id(<addToCartButtonId>)`
Examples:
| addToCartButtonId	                            | itemName                          | itemPageId                |
| add-to-cart-sauce-labs-backpack               | Sauce Labs Backpack               | /inventory-item.html?id=4 |
| add-to-cart-test.allthethings()-t-shirt-(red) | Test.allTheThings() T-Shirt (Red) | /inventory-item.html?id=3 |
| add-to-cart-sauce-labs-fleece-jacket          | Sauce Labs Fleece Jacket          | /inventory-item.html?id=5 |

Scenario: Validate the number of items in the shopping cart
When I change context to element located by `By.cssSelector(.shopping_cart_badge)` in scope of current context
Then the number of items in the shopping cart is equal to 3
 
Scenario: Log Out
When I Log Out