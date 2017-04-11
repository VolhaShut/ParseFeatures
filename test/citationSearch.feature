Feature: Citation Search

  As a user I want to be able to search citations from global search and using citation search

  @component(Search_Results)
  @component(Citation_Search)
  @noAutoLogout
  @jira(LCTS-864)
  @T1
  Scenario Outline: Citation match should show up on appropriate search query
    Given I am on "Home" page
    When I open "<practiceArea>" practice area
      And I perform a search of "<searchQuery>"
    Then I should be on "Results" page
      And I should see "CITATION MATCH" text

  Examples:
    | searchQuery                                | practiceArea             |
    | regulation sk                              | Securities - All |
    | Truth in Securities Act of 1933, ITEM. 100 | Securities - All |
    | Investment Advisors Act, ITEM. 202a        | Securities - All |
    | Regulation AB, ITEM, 1100                  | Securities - All |
    | Rule 501 of Regulation D                   | Antitrust & Competition|
    | 17 CFR 230.482                             | Antitrust & Competition|

  @component(Citation_Search)
  @T1
  @jira(LCTS-616)
  @issue(v10EBF)
  Scenario Outline: Re-execute global citation search from Session Navigator
    Given I am on "Home" page
    When I click "Session Navigator Tab"
