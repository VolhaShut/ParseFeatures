Feature: Content

  "Content" should be available for documents

  # General scenarios ##################################################################################################

  @LB_smoke
  @component(Document_Info)
  @jira(CU-16998)
  @jama(CH-TC-4025)
  Scenario: Verify TOC links (general behaviour)
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - Federal" at "All Items"
    Then I should be on "home/TaxFederal" page
      And I perform a search of "'Federal Tax Regulations'"
    Then I should be on "Results" page
    When I click at the "1st" element of "Documents List"
      And I wait "3000" ms
      And I switch to "1" browser tab
    Then I should be on "Read" page
      And I wait until read page is fully loaded
      And I wait until "Widget Document Contents Icon" is visible

    When I click "Widget Document Contents Icon"
    Then I should see "Contents Tab"
      And I should see "Widget Document Contents Icon Active"
      And I should see "§1.0-1, Internal Revenue Code of 1954 and regulations" in "Highlighted Node"
      And I should see "Internal Revenue Code of 1954 and regulations" in "Active Document On Read View"
      And Text of the "1st" element of "Content Nodes Links" should equal "§1.0-1, Internal Revenue Code of 1954 and regulations"

    When I click at the "1st" element of "Table of Content Top Node Expand Buttons"
    Then Number of "Table of Content Nodes" elements should equal "2"
      And I should see "Final and Temporary Regulations" in "Table of Content Nodes"
      And I should see "Proposed Regulations" in "Table of Content Nodes"
      And I should see "Final and Temporary Regulations" in "Highlighted Node"

    When I hover "2nd" element of "Nodes"
      And I wait "100" ms
      And I click at the "2nd" element of "Nodes"
      And I click on "Table of Content Nodes" element which contains "COMPUTATION OF TAXABLE INCOME"
    Then I should see "§1.61-6, Gains derived from dealings in property." in "Highlighted Node"
      And I should see "Gains derived from dealings in property" in "Active Document On Read View"
      And Text of the "1st" element of "Content Nodes Links" should equal "§1.61-6, Gains derived from dealings in property."


  @component(Content)
  @jira(LCTS-1474)
  @T1
  Scenario: Manipulated open document url should be shown document to user as it is available in system and subscribed or give him proper notification
    Given I am on "Home" page
    When I open URL "https://cheetah-dev-ci.dvl.lynx-app.com/#/read/TaxInternational/09013asdfghe2c83bb7b98!csh-da-filter!WKUS-TAL-DOCS-PHC-%7B3C6CB750-6FE0-4BDC-95CC-9E1099A0ED9A%7D--WKUS_TAL_2713%23teid-0?searchItemId=&da=WKUS_TAL_2713" adress
      And I wait "1000" ms
    Then I should be on "Read" page
      And I wait until read page is fully loaded
      And I should see "Notice" popup
      And I should see "We're sorry, we can't find the specific content you requested, so we have taken you to the beginning of International Taxation by Joseph Isenbergh." text

    When I am on "Home" page
      And I open URL "https://cheetah-dev-ci.dvl.lynx-app.com/#/read/TaxInternational/09013e2c83bb7b98!csh-da-filter!WKUS-TAL-DOCS-PHC-%7B67as607CF9-640C-4326-BD69-74130793D73B%7D--WKUS_TAL_2713%23teid-0?searchItemId=&da=WKUS_TAL_2713" adress
      And I wait "1000" ms
    Then I should be on "Read" page
      And I wait until read page is fully loaded
      And I should not see "Notice" popup
      And Text of "Document Title In Header" should contain "International Taxation by Joseph Isenbergh"

    When I am on "Home" page
      And I open URL "https://cheetah-dev-ci.dvl.lynx-app.com/#/read/TaxInternational/09013e2c83bb7b98!csh-da-filter!WKUS-TAL-DOCS-PHC-%7B67607CF9-640C-4326-BD69-74130793D73B%7D--WKUS_TAL_2713%23te1id-0?searchItemId=&da=WKUS_TAL_2713" adress
      And I wait "1000" ms
    Then I should be on "Read" page
      And I wait until read page is fully loaded
      And I should not see "Notice" popup
      And Text of "Document Title In Header" should contain "International Taxation by Joseph Isenbergh"

