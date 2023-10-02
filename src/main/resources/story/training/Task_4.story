Scenario: Navigate to the website homepage
Given I am on main application page
When I COMPARE_AGAINST baseline with name `loginPage_1` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE	|
|5			                |

Scenario: Log in as a Broken User
Given I Log in as a Broken User
When I COMPARE_AGAINST baseline with name `homepage_1` ignoring:
|ELEMENT                                   | ACCEPTABLE_DIFF_PERCENTAGE |
|By.xpath(//*[@class='inventory_item_img'])| 7                          |