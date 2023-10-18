Meta:
    @group Training
    @requirementId MyTask-0008

Scenario: Navigate to the website homepage
Given I am on main application page

Scenario: Log In
When I log in as an user with `${swagGoodUserName}` and `${swagPassword}`

Scenario: Add items to the shopping cart
When I go to relative URL `inventory.html`
When I select `<sortingValue>` in dropdown located `By.cssSelector(.product_sort_container)`
When I click on all elements located `By.xpath((//*[text()="Add to cart"])[position() <= <cartBadgeCount>])`
When I change context to element located by `By.cssSelector(.shopping_cart_link)`
When I save text of context element to scenario variable `productsInCart`
Then `${productsInCart}` is equal to `<expectedProductsInCart>`
When I take screenshot
Examples:
|sortingValue       |cartBadgeCount|expectedProductsInCart|
|Price (high to low)|2             |2                     |
|Price (low to high)|1             |3                     |

Scenario: Populate checkout data
When I go to relative URL `cart.html`
When I click on element located by `By.id(checkout)`
When I enter `#{generate(regexify '[A-Z]{1}[a-z]{5}')}` in field located by `By.id(first-name)`
When I enter `#{generate(regexify '[A-Z]{1}[a-z]{10}')}` in field located by `By.id(last-name)`
When I enter `#{generate(regexify '[A-Z]{3}-\d{5}')}` in field located by `By.id(postal-code)`
When I COMPARE_AGAINST baseline with name `checkout-step-one` ignoring:
|ELEMENT                       |ACCEPTABLE_DIFF_PERCENTAGE|
|By.cssSelector(.checkout_info)|6.389                     |

When I click on element located by `By.id(continue)`

Scenario: Validate order summary and complete order
When I change context to element located by `By.xpath((//*[@class="inventory_item_price"])[1])`
When I save text of context element to scenario variable `firstProductPrice`
Given I initialize scenario variable `firstProductPrice` with value `#{replaceAllByRegExp(\$, , ${firstProductPrice})}`

When I change context to element located by `By.xpath((//*[@class="inventory_item_price"])[2])`
When I save text of context element to scenario variable `secondProductPrice`
Given I initialize scenario variable `secondProductPrice` with value `#{replaceAllByRegExp(\$, , ${secondProductPrice})}`

When I change context to element located by `By.xpath((//*[@class="inventory_item_price"])[3])`
When I save text of context element to scenario variable `thirdProductPrice`
Given I initialize scenario variable `thirdProductPrice` with value `#{replaceAllByRegExp(\$, , ${thirdProductPrice})}`

When I change context to element located by `By.cssSelector(.summary_subtotal_label)`
When I save text of context element to scenario variable `subTotal`
Given I initialize scenario variable `subTotal` with value `#{replaceAllByRegExp("""Item total: \$""", , ${subTotal})}`
Then `#{eval(${firstProductPrice} + ${secondProductPrice} + ${thirdProductPrice})}` is equal to `${subTotal}`

When I change context to element located by `By.cssSelector(.summary_tax_label)`
When I save text of context element to scenario variable `tax`
Given I initialize scenario variable `tax` with value `#{replaceAllByRegExp("""Tax: \$""", , ${tax})}`

When I change context to element located by `By.cssSelector(.summary_total_label)`
When I save text of context element to scenario variable `total`
Given I initialize scenario variable `total` with value `#{replaceAllByRegExp("""Total: \$""", , ${total})}`
Then `#{round(#{eval(${tax} + ${subTotal})})}` is equal to `#{round(${total})}`

When I go to relative URL `checkout-step-two.html`
When I COMPARE_AGAINST baseline with name `checkout-step-two`
When I click on element located by `By.cssSelector(#finish)`

When I change context to element located by `By.cssSelector(.complete-header)`
When I save text of context element to scenario variable `thankYouMessage`
Then `${thankYouMessage}` is equal to `Thank you for your order`

