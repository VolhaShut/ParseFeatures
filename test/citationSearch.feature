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
    And I click "<PA>" link
    And I perform a search of "other search"
    Then I should be on "Results" page
    And I wait "2000" ms
    And I click "Application Logo"
    When I click "Session Navigator Tab"
    And I click "<PA>" link
    And I perform a search of "<CitationSearch>"
    Then I should be on "Results" page
    And I wait "2000" ms
    And I should see "CITATION MATCHES" text
    And I remember results number in Search Results
    And I click "Application Logo"
    When I click "Session Navigator Tab"
    And I click "<PA>" link
    And I click "Session Navigator Tab"
    And I click at the "1st" element of "Indicators"
    And I wait "1000" ms
    Then Text of "Last Search" should contain "<CitationSearch>"
    When I click "Last Search"
    Then I should be on "Results" page
    And I should see "CITATION MATCHES" text
    And Number of results should be the same

    Examples:
      | CitationSearch                      | PA                     |
      | code 140                            | TAX - ALL              |
      | reg fd                              | Securities - All |

  @component(Citation_Search)
  @T1
  @jira(LCTS-1449)
  @jama(CH-TC-4343)
  @issue(v10EBF)
  @LB_smoke
  Scenario Outline: Re-execute global citation search from History
    Given I am on "Home" page
    When I click "Session Navigator Tab"
      And I click "<PA>" link
      And I perform a search of "other search"
    Then I should be on "Results" page
      And I wait "2000" ms
      And I am on "home" page

    When I click "Session Navigator Tab"
      And I click "<PA>" link
      And I perform a search of "<CitationSearch>"
    Then I should be on "Results" page
      And I wait "2000" ms
      And I should see "CITATION MATCHES" text
      And I remember results number in Search Results
      And I am on "home" page

    When I click "History"
    Then Text of the "1st" element of "History Items No Time" should equal "<CitationSearch>"

    When I click at the "1st" element of "History Items No Time"
    Then I should be on "Results" page
      And I should see "CITATION MATCHES" text
      And Number of results should be the same


    Examples:
      | CitationSearch | PA               |
      | code 140       | TAX - ALL        |
      | reg fd         | SECURITIES - ALL |


  @component(Citation_Search)
  @T1
  @jira(LCTS-541)
  Scenario: Citation search with 0 results
    Given I am on "Home" page
    When I click "Session Navigator Tab"
    And I click "TAX - ALL" link
    And I type "davsdvasdvasdv" in "Citation Lookup Box"
    And I click "Citation Lookup"
    Then I should see "We are unable to locate any documents for the citation value you have entered." text

  @IQA(smoke)
  @component(Citation_Search)
  @T1
  @jira(LCTS-538)
  Scenario: Citation search with one result/Tax
    Given I am on "Home" page
    When I click "Session Navigator Tab"
    And I click "TAX - ALL" link
    And I type "140(a)" in "Citation Lookup Box"
    And I click "Citation Lookup"
    Then I should be on "Read" page


  @component(Citation_Search)
  @T1
  @jira(LCTS-539)
  Scenario: Citation search with more results
    Given I am on "Home" page
    When I click "Session Navigator Tab"
    And I click "TAX - ALL" link
    And I type "s140" in "Citation Lookup Box"
    And I click "Citation Lookup"
    Then I should be on "Result" page
    And I should not see "Narrow Panel"
    And Text of "Citation Lookup Title" should equal "Citation Lookup: s140"
    Then I click "Application Logo"
    And I click "Session Navigator Tab"
    And I click at the "2nd" element of "Indicators" collection
    And Text of the "3rd" element of "All Items" should equal "Citation Lookup: s140"

  @component(Citation_Search)
  @T1
  @jira(LCTS-1450)
  @jira(CU-18461)
  @jama(CH-TC-4342)
  @issue(v10EBF)
  @LB_smoke
  Scenario Outline: Re-execute citation search from History
    Given I am on "Home" page
    When I click "Session Navigator Tab"
    And I click "TAX - ALL" link
    And I type "<CitationSearch>" in "Citation Lookup Box"
    And I click "Citation Lookup"
    Then I should be on "Results" page
    And I remember results number in Search Results
    And I should see "CITATION MATCHES" text
    And I wait "2000" ms
    And I am on "home" page

    When I click "History"
    Then Text of the "1st" element of "History Items No Time" should equal "<CitationSearch>"

    When I click at the "1st" element of "History Items No Time"
    Then I should be on "Results" page
    And I should see "CITATION MATCHES" text
    And Number of results should be the same
    And I should not see "Narrow Panel"
    And I should not see "Hide Filter Panel Button"

    Examples:
      | CitationSearch |
      | irc 1441       |
      | section 1503   |
      | code 401       |


  @component(Citation_Search)
  @T1
  @jira(LCTS-1451)
  @jama(CH-TC-4341)
  @issue(v10EBF)
  @LB_smoke
  Scenario Outline: Re-execute citation search from Session Navigator
    Given I am on "Home" page
    When I click "Session Navigator Tab"
    And I click "TAX - ALL" link
    And I type "<CitationSearch>" in "Citation Lookup Box"
    And I click "Citation Lookup"
    Then I should be on "Results" page
    And I should see "CITATION MATCHES" text
    And I remember results number in Search Results
    And I wait "2000" ms
    And I am on "home" page

    When I click "Session Navigator Tab"
    And I click "TAX - ALL" link
    And I click "Session Navigator Tab"
    And I click at the "1st" element of "Indicators"
    And I wait "500" ms
    Then Text of "Last Search" should contain "<CitationSearch>"

    When I send sequence of keys "ENTER" to element "Focused Element"
    And I wait "1000" ms
    Then I should be on "Results" page
    And I should see "CITATION MATCHES" text
    And Number of results should be the same

    Examples:
      | CitationSearch |
      | irc 1441       |
      | section 1503   |
      | code 401       |




  ######################Smoke test##############################
  @LB_smoke
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-6349)
  @jama(CH-TC-3013)
  @newTabWaitingIssue
  @content_dependent
  Scenario: Verify that user can perform Global Citation Search from different PA - All Content
    Given I am on "Home" page
    When I open "All Content" practice area
      And I perform a search of "1934 Act, 0-10"
    Then I should be on "Results" page
      And I should see "CITATION MATCH" text
      And I should see "KEYWORD MATCHES" text
      And I should see " Federal Securities Law Reporter, Reg. §240.0-10, Small entities under the securities exchange act for purposes of the regulatory flexibility act." in "Citation Match Document Titles"
    When I click "Federal Securities Law Reporter, Reg. §240.0-10, Small entities under the securities exchange act for purposes of the regulatory flexibility act." at "Citation Match Document Titles"
      And I wait "1000" ms
      And I switch to "1" browser tab
      And I wait until read page is fully loaded
    Then I should be on "Read" page
    When I scroll to "Show Metadata Button" element
      And I wait "500" ms
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "document-num" with value "Reg. §240.0-10"
    When I close browser tab

  @LB_smoke
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-6349)
  @jama(CH-TC-3013)
  Scenario: Verify that user can perform Global Citation Search from different PA - Tax-All
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "Home" page
    When I perform a search of "irc 1441"
     And I wait until results page is fully loaded
    Then I should be on "Results" page
      And I should see "CITATION MATCH" text
      And I should see "KEYWORD MATCHES" text
      And I should see "Current Internal Revenue Code, SEC. 1441. WITHHOLDING OF TAX ON NONRESIDENT ALIENS." in "Citation Match Document Titles"
    When I click "Current Internal Revenue Code, SEC. 1441. WITHHOLDING OF TAX ON NONRESIDENT ALIENS." at "Citation Match Document Titles"
      And I wait "1000" ms
      And I switch to "1" browser tab
      And I wait until read page is fully loaded
    Then I should be on "Read" page
    When I scroll to "Show Metadata Button" element
      And I wait "500" ms
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "document-num" with value "SEC. 1441."
    When I close browser tab

  @LB_smoke
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-6349)
  @jama(CH-TC-3013)
  Scenario: Verify that user can perform Global Citation Search from different PA - Securities and Corporate
    Given I am on "Home" page
    When I perform a search of "reg fd"
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And I should see "CITATION MATCH" text
      And I should see "KEYWORD MATCHES" text
    When I click at the "1st" element of "Citation Match Document Titles"
      And I wait "1000" ms
      And I switch to "1" browser tab
      And I wait until read page is fully loaded
    Then I should be on "Read" page
    When I scroll to "Show Metadata Button" element
      And I wait "500" ms
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "document-num" with value "Reg. §243.100."
    When I close browser tab

    ####################Critical path#########################################
  @component(Search)
  @component(Citation_Search)
  @LB_regression
  @jira(CU-18426)
  @jama(CH-TC-4323)
  @causedby(CU-18426)
  Scenario: Verification of citation search in Labor & Employment Law
    Given I am on "Home" page
    When I open Session Navigator menu
      And I click "All Content in PA"
      And I click "Labor & Employment Law" link
      And I perform a search of "29 CFR § 825.100(a)"
    Then I should be on "Results" page
      And I should see "CITATION MATCHES" text
      And I should see "KEYWORD MATCHES" text

    When I click at the "1st" element of "Documents List"
      And I wait "3000" ms
      And I switch to "1" browser tab
    Then I should be on "Read" page

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
      And I wait "1000" ms
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "document-num" with value "§825.100"

  @component(Search)
  @component(Citation_Search)
  @LB_regression
  @jira(CU-18423)
  @jama(CH-TC-4320)
  @critical_bug
  Scenario: Verification of citation search in Pension PA
    Given I am on "Home" page
    When I open Session Navigator menu
      And I click "All Content in PA"
      And I click "Pension" link
      And I perform a search of "26 C.F.R. 1.1361-3(a)"
    Then I should be on "Results" page
      And I should see "Citation Match Document Titles"
      And I should see "CITATION MATCHES" text
      And I should see "KEYWORD MATCHES" text

    When I click at the "1st" element of "Documents List"
      And I wait "3000" ms
      And I switch to "1" browser tab
    Then I should be on "Read" page

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "citation" with value "Reg. Sec. 1.1361-3"

  @component(Search_Results)
  @component(Citation_Search)
  @LB_regression
  @jira(CU-6350)
  @jama(CH-TC-3014)
  Scenario: Verify that PA specific search results are retrieved when the system finds an exact match for a citation
    Given I am on "Home" page
    When I click "Session Navigator Tab"
    And I click "All Content in PA"
    Then I should be on "Home" page
    When I click "Banking & Consumer Finance" link
    Then I should be on "Home/Banking" page

    When I perform a search of "s1441a, bank act"
    Then I should be on "Results" page
      And I wait until results page is fully loaded
      And I should see "Citation Match box"
      And I should see "CITATION MATCH" text
      And Number of "Citation Match Document Titles" elements should be greater than "0"
      And I should see "Keyword Matches Box"
      And I should see "KEYWORD MATCHES" text
      And Number of "Keyword Matches Document Titles" elements should be greater than "0"

    When I click "Thrift Depositor Protection Oversight Board, 12 USC 1441a(a)" at "Citation Match Document Titles"
      And I wait "1000" ms
      And I switch to "next" browser tab
    Then I wait until read page is fully loaded
      And I should be on "Read" page

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
    Then Document metadata should contain parameter "document-num" with value "Sec. 1441a"
      And Document metadata should contain parameter "citation" with value "12 U.S.C. § 1441a"

    When I close browser tab
    Then I wait until results page is fully loaded
      And I should be on "Results" page

    When I remember value of the "2nd" element of "Keyword Matches Document Titles" as "Document Title"
      And I click at the "2nd" element of "Keyword Matches Document Titles"
    Then I wait "1000" ms
    When I switch to "next" browser tab
    Then I wait until read page is fully loaded
      And I should be on "Read" page
      And I should see remembered value as "Document Title" in "Document Titles On Read View"

    When I close browser tab
    Then I wait until results page is fully loaded
      And I should be on "Results" page

    When I click "Home" link
    Then I should be on "Home" page
      And I wait until "Session Navigator" is present

    When I click "Session Navigator Tab"
    And I click "All Content in PA"
    Then I should be on "Home" page

    When I perform a search of "s1441a, bank act"
    Then I should be on "Results" page
      And I wait until results page is fully loaded
      And Number of "Documents List" elements should be greater than "0"
      And I should not see "Citation Match box"
      And I should not see "CITATION MATCH" text
      And I should not see "Keyword Matches Box"
      And I should not see "KEYWORD MATCHES" text

  @LB_regression
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-18416)
  @jama(CH-TC-4315)
  @critical_bug
  Scenario: Verify whether all results are displayed for citation match
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "Home" page
    When I type "reg 12B" in "Citation Lookup Input Field"
      And I click "Citation Lookup Go Button"
      And I wait until results page is fully loaded
      And I scroll down whole page
    Then Number of "Citation Match Document Titles" elements should be greater than "0"
    When I remember number of "Citation Match Document Titles" as "expected citations count"

    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
      And I perform a search of "reg 12B"
      And I wait until results page is fully loaded
      And I scroll down whole page
      And I remember number of "Citation Match Document Titles" as "actual citations count"
    Then I should be on "Results" page
      And I should see "CITATION MATCH" text
      And I should see "KEYWORD MATCHES" text
      And Value remembered as "actual citations count" should be equal to the value remembered as "expected citations count"

  @LB_regression
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-18479)
  @jama(CH-TC-4355)
  @critical_bug
  Scenario: Tax All,Citation term - Sec 104
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "home/Tax" page

    When I type "sec 104" in "Citation Lookup Input Field"
      And I click "Citation Lookup Go Button"
    Then I should see "Citation Match Document Titles"

    When I click at the "1st" element of "Documents List"
      And I remember number of windows as "Number of Windows"
      And I switch to "next" browser tab
    Then Value remembered as "Number of Windows" should be equal "2"
      And I wait until "Show Metadata Button" is present

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And I should see "norm-link-values" in "Metadata Head"
      And I should see "S104" in "Metadata Value"
      And I close browser tab

  @LB_regression
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-18479)
  @jama(CH-TC-4355)
  @critical_bug
  Scenario: Tax All,Citation term - 1.704-1
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "home/Tax" page

    When I type "1.704-1" in "Citation Lookup Input Field"
      And I click "Citation Lookup Go Button"
    Then I should see "Citation Match Document Titles"

    When I click "Federal Tax Regulations, §1.704-1, Partner's distributive share" at "Documents List"
      And I remember number of windows as "Number of Windows"
      And I switch to "next" browser tab
    Then Value remembered as "Number of Windows" should be equal "2"
      And I wait until "Document Title" is present
      And Text of "Document Title" should equal "§1.704-1,Internal Revenue Service,Partner's distributive share"
      And I wait until "Show Metadata Button" is present

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And I should see "norm-link-values" in "Metadata Head"
      And I should see "S1.704-1" in "Metadata Value"
      And I close browser tab

  @LB_regression
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-18479)
  @jama(CH-TC-4355)
  @critical_bug
  Scenario: Tax All,Citation term - 31.3221-1
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "home/Tax" page

    When I type "31.3221-1" in "Citation Lookup Input Field"
      And I click "Citation Lookup Go Button"
      And I wait until "Document Title" is present
      And I remember number of windows as "Number of Windows"
    Then Text of "Document Title" should equal "§31.3221-1,Internal Revenue Service,Measure of employer tax"
      And Value remembered as "Number of Windows" should be equal "1"
      And I wait until "Show Metadata Button" is present

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And I should see "norm-link-values" in "Metadata Head"
      And I should see "S31.3221-1" in "Metadata Value"


  @LB_regression
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-18479)
  @jama(CH-TC-4355)
  @critical_bug
  Scenario: Tax All,Citation term - 31.3306(b)-1T
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "home/Tax" page

    When I type "31.3306(b)-1T" in "Citation Lookup Input Field"
      And I click "Citation Lookup Go Button"
      And I wait until "Document Title" is present
      And I remember number of windows as "Number of Windows"
    Then Text of "Document Title" should equal "§31.3306(b)-1T,Internal Revenue Service,Question and answer relating to the definition of wages in section 3306(b) (Temporary).—"
      And Value remembered as "Number of Windows" should be equal "1"
      And I wait until "Show Metadata Button" is present

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And I should see "norm-link-values" in "Metadata Head"
      And I should see "S31.3306(b)-1T" in "Metadata Value"

  @LB_regression
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-18479)
  @jama(CH-TC-4355)
  @critical_bug
  Scenario: Tax All,Citation term - Rule 102
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - All" at "All Items"
    Then I should be on "home/Securities" page

    When I perform a search of "RegsFD 102"
    Then I should see "Citation Match Document Titles"

    When I click at the "1st" element of "Documents List"
      And I remember number of windows as "Number of Windows"
      And I switch to "next" browser tab
    Then Value remembered as "Number of Windows" should be equal "2"
      And I wait until "Show Metadata Button" is present

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And I should see "norm-link-values" in "Metadata Head"
      And I should see "SECRULE102" in "Metadata Value"
      And I close browser tab

  @LB_regression
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-18479)
  @jama(CH-TC-4355)
  @critical_bug
  Scenario: Tax All,Citation term - Sec 1
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - Federal" at "All Items"
    Then I should be on "home/TaxFederal" page

    When I type "sec1" in "Citation Lookup Input Field"
      And I click "Citation Lookup Go Button"
    Then I should see "Citation Match Document Titles"

    When I click at the "1st" element of "Documents List"
      And I remember number of windows as "Number of Windows"
      And I switch to "next" browser tab
    Then Value remembered as "Number of Windows" should be equal "2"
      And I wait until "Show Metadata Button" is present

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And I should see "norm-link-values" in "Metadata Head"
      And I should see "S1" in "Metadata Value"
      And I close browser tab

  @LB_regression
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-18479)
  @jama(CH-TC-4355)
  @critical_bug
  Scenario: Tax All,Citation term - Sec 2
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - Federal" at "All Items"
    Then I should be on "home/TaxFederal" page

    When I type "sec2" in "Citation Lookup Input Field"
      And I click "Citation Lookup Go Button"
    Then I should see "Citation Match Document Titles"

    When I click at the "1st" element of "Documents List"
      And I remember number of windows as "Number of Windows"
      And I switch to "next" browser tab
    Then Value remembered as "Number of Windows" should be equal "2"
      And I wait until "Show Metadata Button" is present

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
    Then I should see "Document Metadata Info"
      And I should see "norm-link-values" in "Metadata Head"
      And I should see "S2" in "Metadata Value"
      And I close browser tab

  @component(Citation_Search)
  @component(Search_Results)
  @LB_regression
  @jama(CH-TC-4408)
  @jira(CU-18664)
  Scenario Outline: Verify that only one citation match for specific search terms is returned when user performs Global Citation Search from 'Tax - All' PA
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "Home/Tax" page
      And I wait until "TAX - ALL" text is present in "Session Navigator Tab"
    When I type "<searchTerm>" in "Search Input"
      And I wait until "Search Button" is clickable
      And I click "Search Button"
    Then I should be on "Results" page
      And I wait until results page is fully loaded
      And I should see "CITATION MATCH" text
      And Number of "Citation Match Document Titles" elements should equal "1"
     When I click at the "1st" element of "Citation Match Document Titles"
      And I wait "500" ms
      And I switch to "next" browser tab
      And I wait until read page is fully loaded
    Then I should be on "Read" page
      And Text of "Document Title" should contain "<docTitle>"
      And I close browser tab

    Examples:
      | searchTerm                            | docTitle                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
      | S1(h)                                 | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | S 1(h)                                | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | S.1(h)                                | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | S. 1(h)                               | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | Sec1(h)                               | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | Sec 1(h)                              | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | Sec.1(h)                              | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | Sec. 1(h)                             | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | Section1(h)                           | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | Section 1(h)                          | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | IRC1(h)                               | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | IRC 1(h)                              | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | Internal Revenue Code 1(h)            | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | Code Section 1(h)                     | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | Code Sec. 1(h)                        | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 26 usc 1(h)                           | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 26 U.S.C. 1(h)                        | SEC. 1.TAX IMPOSED                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 1.355-1(c)                            | §1.355-1,Internal Revenue Service,Distribution of stock and securities of a controlled corporation                                                                                                                                                                                                                                                                                                                                                                      |
      | S1.355-1(c)                           | §1.355-1,Internal Revenue Service,Distribution of stock and securities of a controlled corporation                                                                                                                                                                                                                                                                                                                                                                      |
      | S 1.355-1(c)                          | §1.355-1,Internal Revenue Service,Distribution of stock and securities of a controlled corporation                                                                                                                                                                                                                                                                                                                                                                      |
      | S.1.355-1(c)                          | §1.355-1,Internal Revenue Service,Distribution of stock and securities of a controlled corporation                                                                                                                                                                                                                                                                                                                                                                      |
      | S. 1.355-1(c)                         | §1.355-1,Internal Revenue Service,Distribution of stock and securities of a controlled corporation                                                                                                                                                                                                                                                                                                                                                                      |
      | Sec1.355-1(c)                         | §1.355-1,Internal Revenue Service,Distribution of stock and securities of a controlled corporation                                                                                                                                                                                                                                                                                                                                                                      |
      | Sec 1.355-1(c)                        | §1.355-1,Internal Revenue Service,Distribution of stock and securities of a controlled corporation                                                                                                                                                                                                                                                                                                                                                                      |
      | Sec.1.355-1(c)                        | §1.355-1,Internal Revenue Service,Distribution of stock and securities of a controlled corporation                                                                                                                                                                                                                                                                                                                                                                      |
      | Sec. 1.355-1(c)                       | §1.355-1,Internal Revenue Service,Distribution of stock and securities of a controlled corporation                                                                                                                                                                                                                                                                                                                                                                      |
      | Treas Reg 1.355-2(c)                  | §1.355-2,Internal Revenue Service,Limitations                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Treas. Reg 1.355-2(c)                 | §1.355-2,Internal Revenue Service,Limitations                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Treas Reg. 1.355-2(c)                 | §1.355-2,Internal Revenue Service,Limitations                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Treas. Reg. 1.355-2(c)                | §1.355-2,Internal Revenue Service,Limitations                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Treas Regulation 1.355-2(c)           | §1.355-2,Internal Revenue Service,Limitations                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Treas. Regulation 1.355-2(c)          | §1.355-2,Internal Revenue Service,Limitations                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Treasury Regulation 1.355-2(c)        | §1.355-2,Internal Revenue Service,Limitations                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | 26 cfr 1.355-2(c)                     | §1.355-2,Internal Revenue Service,Limitations                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | 26 C.F.R. 1.355-2(c)                  | §1.355-2,Internal Revenue Service,Limitations                                                                                                                                                                                                                                                                                                                                                                                                                           |
      | Rev Rul 2006-20                       | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Rev. Rul. 2006-20                     | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Rev Rul 2006-20                       | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Rev. Rul. 2006-20                     | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Revenue Rul 2006-20                   | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Revenue Rul. 2006-20                  | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Revenue Rule 2006-20                  | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Revenue Ruling 2006-20                | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Rev Rule 2006-20                      | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Rev. Rule 2006-20                     | Rev. Rul. 2006-20,Internal Revenue Service,(Mar. 16, 2006)                                                                                                                                                                                                                                                                                                                                                                                                               |
      | Announcement 2011-8                   | Announcement 2011-8,Internal Revenue Service,(Jan. 31, 2011)                                                                                                                                                                                                                                                                                                                                                                                                             |
      | IRS Announcement 2011-8               | Announcement 2011-8,Internal Revenue Service,(Jan. 31, 2011)                                                                                                                                                                                                                                                                                                                                                                                                             |
      | Notice 2012-48                        | Notice 2012-48,Internal Revenue Service,(Jul. 16, 2012)                                                                                                                                                                                                                                                                                                                                                                                                                  |
      | IRS Notice 2012-48                    | Notice 2012-48,Internal Revenue Service,(Jul. 16, 2012)                                                                                                                                                                                                                                                                                                                                                                                                                  |
      | Pub 17                                | IRS Publication 17: Your Federal Income Tax [2016],Internal Revenue Service                                                                                                                                                                                                                                                                                                                                                                            |
      | IRS Pub 17                            | IRS Publication 17: Your Federal Income Tax [2016],Internal Revenue Service                                                                                                                                                                                                                                                                                                                                                                            |
      | Publication 17                        | IRS Publication 17: Your Federal Income Tax [2016],Internal Revenue Service                                                                                                                                                                                                                                                                                                                                                                            |
      | IRS Publication 17                    | IRS Publication 17: Your Federal Income Tax [2016],Internal Revenue Service                                                                                                                                                                                                                                                                                                                                                                            |
      | PLR 201244003                         | UIL No. 0301.00-00 Distributions of property. UIL No. 0855.01-00 Dividends paid by regulated investment company after close of taxable year; General rule. UIL No. 1296.00-00 Passive foreign investment company. UIL No. 9100.22-00 Extension of time for making certain elections; Other. IRS Letter Ruling 201244003 (Jul. 27, 2012),Internal Revenue Service,(Jul. 27, 2012)                                                                                         |
      | IRS PLR 201244003                     | UIL No. 0301.00-00 Distributions of property. UIL No. 0855.01-00 Dividends paid by regulated investment company after close of taxable year; General rule. UIL No. 1296.00-00 Passive foreign investment company. UIL No. 9100.22-00 Extension of time for making certain elections; Other. IRS Letter Ruling 201244003 (Jul. 27, 2012),Internal Revenue Service,(Jul. 27, 2012)                                                                                         |
      | Private Letter Ruling 201244003       | UIL No. 0301.00-00 Distributions of property. UIL No. 0855.01-00 Dividends paid by regulated investment company after close of taxable year; General rule. UIL No. 1296.00-00 Passive foreign investment company. UIL No. 9100.22-00 Extension of time for making certain elections; Other. IRS Letter Ruling 201244003 (Jul. 27, 2012),Internal Revenue Service,(Jul. 27, 2012)                                                                                         |
      | Private Letter Rulings 201244003      | UIL No. 0301.00-00 Distributions of property. UIL No. 0855.01-00 Dividends paid by regulated investment company after close of taxable year; General rule. UIL No. 1296.00-00 Passive foreign investment company. UIL No. 9100.22-00 Extension of time for making certain elections; Other. IRS Letter Ruling 201244003 (Jul. 27, 2012),Internal Revenue Service,(Jul. 27, 2012)                                                                                         |
      | TAM 201035016                         | UIL No. 0446.03-00 General rule for methods of accounting (Permissible v. not permissible); Methods of accounting (Permissible method v. not permissible). UIL No. 0446.04-00 General rule for methods of accounting (Permissible v. not permissible); Change of methods (Permissible v. not permissible). UIL No. 0469.00-00 Passive activity losses and credits limited. Technical Advice Memorandum 201035016 (Jun. 03, 2010),Internal Revenue Service,(Jun. 3, 2010) |
      | IRS TAM 201035016                     | UIL No. 0446.03-00 General rule for methods of accounting (Permissible v. not permissible); Methods of accounting (Permissible method v. not permissible). UIL No. 0446.04-00 General rule for methods of accounting (Permissible v. not permissible); Change of methods (Permissible v. not permissible). UIL No. 0469.00-00 Passive activity losses and credits limited. Technical Advice Memorandum 201035016 (Jun. 03, 2010),Internal Revenue Service,(Jun. 3, 2010) |
      | Technical Advice Memoranda 201035016  | UIL No. 0446.03-00 General rule for methods of accounting (Permissible v. not permissible); Methods of accounting (Permissible method v. not permissible). UIL No. 0446.04-00 General rule for methods of accounting (Permissible v. not permissible); Change of methods (Permissible v. not permissible). UIL No. 0469.00-00 Passive activity losses and credits limited. Technical Advice Memorandum 201035016 (Jun. 03, 2010),Internal Revenue Service,(Jun. 3, 2010) |
      | Technical Advice Memorandum 201035016 | UIL No. 0446.03-00 General rule for methods of accounting (Permissible v. not permissible); Methods of accounting (Permissible method v. not permissible). UIL No. 0446.04-00 General rule for methods of accounting (Permissible v. not permissible); Change of methods (Permissible v. not permissible). UIL No. 0469.00-00 Passive activity losses and credits limited. Technical Advice Memorandum 201035016 (Jun. 03, 2010),Internal Revenue Service,(Jun. 3, 2010) |
      | CCA 200917030                         | UIL No. 6501.00-00 Limitations on assessment and collection (Barred v. not barred). IRS Letter Ruling 200917030 (Dec. 02, 2008),Internal Revenue Service,(Dec. 2, 2008)                                                                                                                                                                                                                                                                                                  |
      | IRS CCA 200917030                     | UIL No. 6501.00-00 Limitations on assessment and collection (Barred v. not barred). IRS Letter Ruling 200917030 (Dec. 02, 2008),Internal Revenue Service,(Dec. 2, 2008)                                                                                                                                                                                                                                                                                                  |
      | FSA 200128011                         | UIL No. 926.00-00 Distributions to shareholders; UIL No. 2511.00-00 Transfers in general (Gift v. not a gift), Field Service Advice 200128011 ,Internal Revenue Service,(Apr. 6, 2001)                                                                                                                                                                                                                                                                                   |
      | IRS FSA 200128011                     | UIL No. 926.00-00 Distributions to shareholders; UIL No. 2511.00-00 Transfers in general (Gift v. not a gift), Field Service Advice 200128011 ,Internal Revenue Service,(Apr. 6, 2001)                                                                                                                                                                                                                                                                                   |
      | Field Service Advice 200128011        | UIL No. 926.00-00 Distributions to shareholders; UIL No. 2511.00-00 Transfers in general (Gift v. not a gift), Field Service Advice 200128011 ,Internal Revenue Service,(Apr. 6, 2001)                                                                                                                                                                                                                                                                                   |
      | AOD 2012-04                           | Joanne Wandry v. Commissioner, File No.: AOD 2012-04 (November 13, 2012),AOD 201204,Internal Revenue Service,(Nov. 13, 2012)                                                                                                                                                                                                                                                                                                                                             |
      | IRS AOD 2012-04                       | Joanne Wandry v. Commissioner, File No.: AOD 2012-04 (November 13, 2012),AOD 201204,Internal Revenue Service,(Nov. 13, 2012)                                                                                                                                                                                                                                                                                                                                             |
      | Action on Decision 2012-04            | Joanne Wandry v. Commissioner, File No.: AOD 2012-04 (November 13, 2012),AOD 201204,Internal Revenue Service,(Nov. 13, 2012)                                                                                                                                                                                                                                                                                                                                             |
      | IRM 5.1.8                             | Section 5.1.8,Courtesy Investigations,Internal Revenue Service,(Nov. 10, 2015)                                                                                                                                                                                                                                                                                                                                                                                          |
      | IRS Manual 5.1.8                      | Section 5.1.8,Courtesy Investigations,Internal Revenue Service,(Nov. 10, 2015)                                                                                                                                                                                                                                                                                                                                                                                          |
      | Internal Revenue Manual 5.1.8         | Section 5.1.8,Courtesy Investigations,Internal Revenue Service,(Nov. 10, 2015)                                                                                                                                                                                                                                                                                                                                                                                          |
      | GCM 39889                             | UIL No. 501.50-00 Exemptions from tax on corporations, certain trusts, etc., Labor organizations, GCM 39889, (Dec. 26, 1995),Internal Revenue Service,(Dec. 26, 1995)                                                                                                                                                                                                                                                                                                    |
      | IRS GCM 39889                         | UIL No. 501.50-00 Exemptions from tax on corporations, certain trusts, etc., Labor organizations, GCM 39889, (Dec. 26, 1995),Internal Revenue Service,(Dec. 26, 1995)                                                                                                                                                                                                                                                                                                    |
      | General Counsel Memoranda 39889       | UIL No. 501.50-00 Exemptions from tax on corporations, certain trusts, etc., Labor organizations, GCM 39889, (Dec. 26, 1995),Internal Revenue Service,(Dec. 26, 1995)                                                                                                                                                                                                                                                                                                    |
      | General Counsel Memorandum 39889      | UIL No. 501.50-00 Exemptions from tax on corporations, certain trusts, etc., Labor organizations, GCM 39889, (Dec. 26, 1995),Internal Revenue Service,(Dec. 26, 1995)                                                                                                                                                                                                                                                                                                    |

  @component(Citation_Search)
  @component(Search_Results)
  @LB_regression
  @jama(CH-TC-4408)
  @jira(CU-18664)
  @causedby(CNDUP-3651)
  Scenario Outline: Verify that only one citation match for specific search terms is returned when user performs Global Citation Search from 'Tax - All' PA (CNDUP-3373)
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "Home/Tax" page
      And I wait until "TAX - ALL" text is present in "Session Navigator Tab"
    When I type "<searchTerm>" in "Search Input"
      And I wait until "Search Button" is clickable
      And I click "Search Button"
    Then I should be on "Results" page
      And I wait until results page is fully loaded
      And I should see "CITATION MATCH" text
      And Number of "Citation Match Document Titles" elements should equal "1"
    When I click at the "1st" element of "Citation Match Document Titles"
      And I wait "500" ms
      And I switch to "next" browser tab
      And I wait until read page is fully loaded
    Then I should be on "Read" page
      And I close browser tab

    Examples:
      | searchTerm                                      |
      | TEAM 200430029                                  |
      | IRS TEAM 200430029                              |
      | Technical Expedited Advice Memoranda 200430029  |
      | Technical Expedited Advice Memorandum 200430029 |
      | Chief Counsel Advice Memoranda CCA 200917030    |
      | Chief Counsel Advice Memorandum CCA 200917030   |
      | Information Letter 2012-0049                    |
      | IRS Information Letter 2012-0049                |
      | LBI 03042005                                    |
      | GLAM AM-2009-013                                |
      | IRS GLAM AM-2009-013                            |
      | General Legal Advice Memoranda AM-2009-013      |
      | IRS General Legal Advice Memoranda AM-2009-013  |
      | Generic Legal Advice Memorandum AM-2009-013     |
      | IRS Generic Legal Advice Memorandum AM-2009-013 |
      | SCA 200235029                                   |
      | IRS SCA 200235029                               |
      | Service Center Advice 200235029                 |

  @LB_regression
  @component(Search_Results)
  @component(Citation_Search)
  @jira(CU-18663)
  @jama(CH-TC-4406)
  Scenario Outline: Verified that more than one citation match for specific seach terms is returned when user performs Global Citation Search from 'Tax - All' PA
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "Home/Tax" page

    When I perform a search of "<searchTerm>"
    Then I should be on "Results" page
      And I should see "CITATION MATCHES" text
      And Number of "Citation Match Document Titles" elements should be greater than "1"

    When I click at the "1st" element of "Citation Match Document Titles"
      And I remember number of windows as "Number of Windows"
      And I switch to "next" browser tab
    Then Value remembered as "Number of Windows" should be equal "2"
      And I should be on "Read" page
      And I close browser tab

    Examples:
      | searchTerm                    |
      | Rev Proc 2011-52              |
      | Revenue Proc 2011-52          |
      | Rev Procedure 2011-52         |
      | Revenue Procedure 2011-52     |
      | IRS Rev Proc 2011-52          |
      | IRS Revenue Proc 2011-52      |
      | IRS Rev Procedure 2011-52     |
      | IRS Revenue Procedure 2011-52 |
      | Release IR-2012-67            |
      | Press Release IR-2012-67      |
      | IRS Press Release IR-2012-67  |

  @component(Citation_Search)
  @component(Search)
  @LB_regression_P2
  @jama(CH-TC-4057)
  @jira(CU-17252)
  Scenario: Keyword Matches bar isn't displayed after citation search and sorting results by Document Type
    Given I am on "Home" page
    When I wait until "Session Navigator Tab" is visible
      And I click "Session Navigator"
      And I click "All Content" at "All Items"
      And I wait until "ALL CONTENT" text is present in "Session Navigator Tab"
    Then I should be on "Home" page

    When I perform a search of "IRC sec 101"
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should see "CITATION MATCHES" text
      And I should see "KEYWORD MATCHES" text
      And I should see collection of "Citation Match Document Titles"

    When I click "Sorting Button"
    Then I should see "Document Type" in "Sorting Items"
      And I should see "Most Recent" in "Sorting Items"
      And I should see "Relevance" in "Sorting Items"
    When I click "Document Type" link
    Then I should see "Document Type" in "Sorting Button"
      And I wait until results page is fully loaded
      And I should see "CITATION MATCHES" text
      And I should not see "KEYWORD MATCHES" text
      And I should see collection of "Citation Match Document Titles"
      And I should see collection of "Cluster Names"

  @component(Citation_Search)
  @component(Search)
  @LB_regression_P2
  @jama(CH-TC-4508)
  @jira(CU-18746)
  Scenario Outline: Verify that Global search with plain numbers without prefix do not return citation results
    Given I am on "Home" page
    When I wait until "Session Navigator Tab" is visible
      And I click "Session Navigator"
      And I click "Tax - All" at "All Items"
      And I wait until "TAX - ALL" text is present in "Session Navigator Tab"
    Then I should be on "Home" page

    When I perform a search of "<searchTerm>"
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should not see "CITATION MATCHES" text
      And I should not see "KEYWORD MATCHES" text
      And I should not see collection of "Citation Match Document Titles"
    Examples:
      | searchTerm |
      | 1.355-1(c) |
      | 1.355-1    |
      | 1(h)       |
      | 1          |

  @component(Citation_Search)
  @component(History)
  @LB_regression_P2
  @jama(CH-TC-3024)
  @jira(CU-6361)
  Scenario: Verify the search results are maintained as combo search on Accessing the search from History
    Given I am on "Home" page
    When I wait until "Session Navigator Tab" is visible
      And I click "Session Navigator"
      And I click "All Content" at "All Items"
      And I wait until "ALL CONTENT" text is present in "Session Navigator Tab"
    Then I should be on "Home" page

    When I perform a search of "Reg S"
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should see "CITATION MATCHES" text
      And I should see "KEYWORD MATCHES" text
      And I should see collection of "Citation Match Document Titles"

    When I remember a number from "Number Of Results" element as "resultsNumber1"
      And I click "Back Button"
    Then I wait until "Session Navigator Tab" is visible
      And I should be on "Home" page

    When I click "History"
      And I click "See All History"
    Then I should see "History popup"

    When I click at the "1st" element of "History Items Links"
      And I wait until results page is fully loaded
    Then I should be on "Results" page

    When I remember a number from "Number Of Results" element as "resultsNumber2"
    Then Value remembered as "resultsNumber2" should be equal to the value remembered as "resultsNumber1"
      And Number of "Documents List" elements should be greater than "0"
      And I should see "CITATION MATCHES" text
      And I should see "KEYWORD MATCHES" text
      And I should see collection of "Citation Match Document Titles"

  @component(Citation_Search)
  @component(Search)
  @LB_regression_P2
  @jama(CH-TC-4526)
  @jira(CU-18801)
  Scenario Outline: Cascade search from 'Human Resources' - 'Labor & Employment Law'
    Given I am on "Home" page
    When I wait until "Session Navigator Tab" is visible
      And I click "Session Navigator"
      And I click "All Content" at "All Items"
      And I wait until "ALL CONTENT" text is present in "Session Navigator Tab"
    Then I should be on "Home" page

    When I click "<paName>" link
      And I perform a search of "<searchTerm>"
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And Number of "Citation Match Document Titles" elements should equal "1"
      And I should see "<citationResult>" in "Citation Match Document Titles"
    Examples:
      | paName                 | searchTerm               | citationResult                                                                                    |
      | Human Resources        | ADA Sec. 3               | Employment Practices Federal Laws, Sec. 3. [42 U.S.C. 12102], Definition of Disability            |
      | Human Resources        | FMLA Sec. 101            | Wages-Hours: Federal Laws, Sec. 101. [29 U.S.C. 2611]. Definitions                                |
      | Human Resources        | Title VII Sec. 701       | Employment Practices Federal Laws, Sec. 701. [42 U.S.C. 2000e], Definitions                       |
      | Human Resources        | FLSA Sec. 13(a)(1)       | Wages-Hours: Federal Laws, Sec. 13. [29 U.S.C. 213], EXEMPTIONS                                   |
      | Human Resources        | Treasury Reg. §31.3301-2 | Federal Tax Regulations, §31.3301-2, Measure of tax                                               |
      | Human Resources        | SS Act §201(a)(1)        | Social Security Reporter, Sec. 201 (a), Federal Old-Age and Survivors Insurance Trust Fund        |
      | Labor & Employment Law | Treasury Reg. §31.3301-2 | Federal Tax Regulations, §31.3301-2, Measure of tax                                               |
      | Labor & Employment Law | SS Act §201(a)(1)        | Social Security Reporter, Sec. 201 (a), Federal Old-Age and Survivors Insurance Trust Fund        |
      | Labor & Employment Law | IRC Sec. 401(k)          | Current Internal Revenue Code, SEC. 401. QUALIFIED PENSION, PROFIT-SHARING, AND STOCK BONUS PLANS |

  @component(Citation_Search)
  @component(Saved_Searches)
  @LB_regression_P2
  @jama(CH-TC-3023)
  @jira(CU-6362)
  Scenario: Verify the search results are maintained as combo search on Accessing the search from History
    Given I am on "Home" page
    When I wait until "Session Navigator Tab" is visible
      And I click "Session Navigator"
      And I click "All Content" at "All Items"
      And I wait until "ALL CONTENT" text is present in "Session Navigator Tab"
    Then I should be on "Home" page

    When I perform a search of "Reg S"
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should see "CITATION MATCHES" text
      And I should see "KEYWORD MATCHES" text
      And I should see collection of "Citation Match Document Titles"

    When I remember a number from "Number Of Results" element as "resultsNumber1"
      And I click "Save Search Button"
    Then I should see "Save Search Popup"

    When I type random value in "Input Field" field
      And I remember value of "Input Field" field
      And I wait until "Save and Close Button" is clickable
      And I click "Save and Close Button"
    Then I should not see "Save Search Popup"

    When I click "Home Link"
      And I click "Saved Items Menu"
      And I click "Saved Searches" link
      And I wait until "Saved Searches Popup" is visible
    Then I should see "Saved Searches Popup"
      And Text of the "1st" element of "Saved Searches" should equal remembered value

    When I click at the "1st" element of "Saved Searches"
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should see "CITATION MATCHES" text
      And I should see "KEYWORD MATCHES" text
      And I should see collection of "Citation Match Document Titles"

    When I remember a number from "Number Of Results" element as "resultsNumber2"
    Then Value remembered as "resultsNumber2" should be equal to the value remembered as "resultsNumber1"

  @component(Citation_Search)
  @LB_regression_P2
  @jama(CH-TC-4810)
  @jira(CU-19729)
  Scenario: Verify rerunning Citation Lookup search with specific terms from History
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "Home" page

    When I type "cod 5" in "Citation Lookup Input Field"
      And I click "Citation Lookup Go Button"
    Then I should be on "Results" page
      And I should see a collection of "Citation Match Document Titles"

    When I remember order of "Citation Match Document Titles" as "cod 5 Results"
      And I click "History"
      And I wait until "1st" element of "History View Dropdown Values" is clickable
      And I click "cod 5" at "History View Dropdown Values"
    Then I should be on "Results" page
      And I should see a collection of "Citation Match Document Titles"
    Then Collection "Citation Match Document Titles" should be sorted like collection remembered as "cod 5 Results"

  @LB_regression
  @jama(CH-TC-4842)
  @jira(CU-19796)
  @component(Citation_Search)
  Scenario: Citation Search - Verify 'Search' button is disabled until all required fields are completed
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"
      And "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
    
    When I click "Acts & Statutes" at "Type Dropdown In Citation Search Overlay Values"
    Then "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Securities Act of 1933" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
    Then I should see "Format Field In Citation Search Overlay"
      And "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I type "27(a)(3)" in "Format Field In Citation Search Overlay"
    Then "Search Button In Citation Search Overlay" should be enabled

    When I clear "Format Field In Citation Search Overlay" field
    Then "Search Button In Citation Search Overlay" should be disabled

  @LB_regression
  @jama(CH-TC-4843)
  @jira(CU-19798)
  @component(Citation_Search)
  Scenario: Citation Search - Verify that inline error message is displayed if NO results are found OR term is entered in incorrect format/syntax
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"
      And "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Acts & Statutes" at "Type Dropdown In Citation Search Overlay Values"
    Then "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Securities Act of 1933" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
    Then I should see "Format Field In Citation Search Overlay"
      And "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I type "-" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "2000" ms
    Then I should see "Citation Search Overlay Error Message"
      And Text of "Citation Search Overlay Error Message" should equal "We are unable to locate any documents for the citation you have entered."

  @LB_regression
  @jama(CH-TC-4843)
  @jira(CU-19798)
  @component(Citation_Search)
  Scenario Outline: Citation Search - Verify that inline error message is displayed if NO results are found OR term is entered in incorrect format/syntax
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"

    When I wait "2000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
      And I click "<firstDropdownValue>" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "2000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
      And I click "<secondDropdownValue>" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present

    When I wait "2000" ms
      And I type "<term>" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "2000" ms
    Then I should see "Citation Search Overlay Error Message"
      And Text of "Citation Search Overlay Error Message" should equal "We are unable to locate any documents for the citation you have entered."
    
    Examples:
      | firstDropdownValue  | secondDropdownValue             | term    |
      | Agency Materials    | Accounting & Auditing           | "1"     |
      | Reporters           | Commodity Futures Law Reporter  | "!@#3"  |
      | Rules & Regulations | Rules or Regulations            | %^*_-+= |

  @LB_regression
  @jama(CH-TC-4843)
  @jira(CU-19798)
  @component(Citation_Search)
  Scenario: Citation Search - Verify that inline error message is displayed if NO results are found OR term is entered in incorrect format/syntax
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"

    When I wait "2000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
      And I click "Forms & Schedules" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "2000" ms
      And I wait until "Format Field In Citation Search Overlay" is present

    When I wait "2000" ms
      And I type "()" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "2000" ms
    Then I should see "Citation Search Overlay Error Message"
      And Text of "Citation Search Overlay Error Message" should equal "We are unable to locate any documents for the citation you have entered."

  @LB_regression
  @jama(CH-TC-4839)
  @jira(CU-19793)
  @component(Citation_Search)
  Scenario Outline: Verify that user can perform citation search for 'Reporters' type
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"
      And "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
    When I click "Reporters" at "Type Dropdown In Citation Search Overlay Values"
    Then I should see "Reporters" in "Type Dropdowns In Citation Search Overlay"

    When I wait "2000" ms
    Then I should see "- Select -" in "Type Dropdowns In Citation Search Overlay"
    When I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
      And I should see "Commodity Futures Law Reporter" in "Type Dropdown In Citation Search Overlay Values"
      And I should see "Federal Securities Law Reporter" in "Type Dropdown In Citation Search Overlay Values"

    When I click "<secondDropdownValue>" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
      And I wait "2000" ms
    Then I should see "Format Field In Citation Search Overlay"
      And Text of "Format Field In Citation Search Overlay Title" should equal "<citationTitle>"
      And Text of "Format Field In Citation Search Overlay Sample" should equal "<citationSample>"

    When I type "<searchTerm>" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "2000" ms
    Then I should be on "Read" page
    When I wait until read page is fully loaded
    Then Text of "Document Title" should contain "<docTitlePar>"
      And Text of "Document Title" should contain "<docTitle>"

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
     And I wait until "Document Metadata Info" is visible
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "pubvol" with value "<metadataValue>"

    Examples:
      | secondDropdownValue             | citationTitle       | citationSample                        | searchTerm | docTitlePar | docTitle                                         | metadataValue |
      | Commodity Futures Law Reporter  | Comm. Fut. L. Rep.¶ | Example: 131 or 22,563                | 171        | ¶171        | Standards for Records and Reports                | cfl01         |
      | Federal Securities Law Reporter | Fed. Sec. L. Rep. ¶ | Example: 2706 or 2706.13 or 22,774.20 | 371.25     | ¶371.25     | Customer complaints—Reporting violations of law | sec01         |

  @LB_regression
  @jama(CH-TC-4837)
  @jira(CU-19791)
  @component(Citation_Search)
  Scenario Outline: Verify that user can perform citation search for 'Agency Materials' type
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"

    When I wait "5000" ms
      And I wait until "1st" element of "Type Dropdowns In Citation Search Overlay" is visible
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Agency Materials" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "3000" ms
    Then Text of the "2nd" element of "Type Dropdowns In Citation Search Overlay" should equal "Select"

    When I wait "3000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
      And I wait "500" ms
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
      And I should see the following lines in "Type Dropdown In Citation Search Overlay Values":
        | - Select -                                   |
        | Accounting & Auditing Enforcement Releases   |
        | Accounting Series Releases                   |
        | CFTC Staff Letters                           |
        | Codification of Financial Reporting Policies |
        | Comment Letters                              |
        | Financial Reporting Releases                 |
        | Industry Guides                              |
        | No-Action Letters                            |
        | Staff Accounting Bulletins                   |
        | Staff Legal Bulletins                        |

    When I click "<secondDropdownValue>" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
      And I wait "3000" ms
    Then I should see "Format Field In Citation Search Overlay"
      And Text of "Format Field In Citation Search Overlay Title" should equal "<citationTitle>"
      And Text of "Format Field In Citation Search Overlay Sample" should equal "<citationSample>"

    When I type "<searchTerm>" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "3000" ms
    Then I should be on "Read" page
      And I wait until read page is fully loaded
      And Text of "Document Title" should contain "<docTitle>"

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
      And I wait until "Document Metadata Info" is visible
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "pubvol" with value "<metadataValue>"

    Examples:
      | secondDropdownValue                          | citationTitle                                  | citationSample                             | searchTerm           | docTitle                                                                                                                                                                                                                                                                   | metadataValue |
      | Accounting & Auditing Enforcement Releases   | AAER No.                                       | Example: 3736                              | 305                  | RELEASE NO. 305 Securities and Exchange Commission v. Aulie United States District Court for The District of Columbia. Civil Action No. 91-1663. July 9, 1991. Litigation Release No. 12899.,Securities and Exchange Commission,(Jul. 9, 1991)                             | sec01         |
      | Accounting Series Releases                   | Accounting Series Release No.                  | Example: 146A                              | 307                  | Accounting Series RELEASE NO. 307 Rescission of Certain Accounting Series Releases Relating to the Computation of the Ratio of Earnings to Fixed Charges Securities Act Release No 6386. Exchange Act Release No. 18527.,Securities and Exchange Commission,(Mar. 3, 1982) | sec01         |
      | Codification of Financial Reporting Policies | Codification of Financial Reporting Policies § | Example: 206.02.a.iii                      | 102.01.e             | 102.01.e.Considerations for the Future,Securities and Exchange Commission                                                                                                                                                                                                  | sec01         |
      | Comment Letters                              | File Number or Accession Number:               | Example: 002-26821 or 0000000000-07-060247 | 0000000000-15-012160 | TENAX THERAPEUTICS, INC. (Public Availability Date: April 06, 2015),Securities and Exchange Commission,(Apr. 6, 2015)                                                                                                                                                      | cmu13         |
      | Industry Guides                              | Industry Guide No.                             | Example: 7                                 | 7                    | Guide 7.,Securities and Exchange Commission,Guide 7—Description of Property by Issuers Engaged or to Be Engaged in Significant Mining Operations                                                                                                                          | sec01         |
      | No-Action Letters                            | WSB No.                                        | Example: 1013201501                        | 1006200801           | Pershing LLC,Securities and Exchange Commission,(Sept. 10, 2008)                                                                                                                                                                                                           | sdv02         |
      | Staff Accounting Bulletins                   | Staff Accounting Bulletin No.                  | Example: 115                               | 115                  | Staff Accounting Bulletin No. 115,Securities and Exchange Commission,(Nov. 21, 2014)                                                                                                                                                                                       | sec01         |
      | Staff Legal Bulletins                        | Staff Legal Bulletin No.                       | Example: 9 or 1A                           | 14e                  | Staff Legal Bulletin No. 14E(CF),Securities and Exchange Commission                                                                                                                                                                                                        | sec01         |

  @LB_regression
  @jama(CH-TC-4837)
  @jira(CU-19791)
  @component(Citation_Search)
  Scenario Outline: Verify that user can perform citation search for 'Agency Materials' type - results
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"

    When I wait "5000" ms
      And I wait until "1st" element of "Type Dropdowns In Citation Search Overlay" is visible
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Agency Materials" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "3000" ms
    Then Text of the "2nd" element of "Type Dropdowns In Citation Search Overlay" should equal "Select"

    When I wait "3000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
      And I should see the following lines in "Type Dropdown In Citation Search Overlay Values":
        | - Select -                                   |
        | Accounting & Auditing Enforcement Releases   |
        | Accounting Series Releases                   |
        | CFTC Staff Letters                           |
        | Codification of Financial Reporting Policies |
        | Comment Letters                              |
        | Financial Reporting Releases                 |
        | Industry Guides                              |
        | No-Action Letters                            |
        | Staff Accounting Bulletins                   |
        | Staff Legal Bulletins                        |

    When I click "<secondDropdownValue>" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
      And I wait "3000" ms
    Then I should see "Format Field In Citation Search Overlay"
      And Text of "Format Field In Citation Search Overlay Title" should equal "<citationTitle>"
      And Text of "Format Field In Citation Search Overlay Sample" should equal "<citationSample>"

    When I type "<searchTerm>" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "2000" ms
    Then I should be on "Results" page
      And I wait until results page is fully loaded
      And Number of "Documents List" elements should equal "2"
      And I should see "CITATION MATCHES" text
      And I should not see "Search Within Query"
      And I should not see "Search Input"
      And I should not see "Refine Search Scope Link"
      And I should not see "Save Search Button"
      And I should not see "Sort by menu"
      And I should not see a collection of "Filter Items"
      And I should see "<docTitle1>" text
      And I should see "<docTitle2>" text

    When I click "<docTitle1>" at "Citation Match Document Titles"
      And I wait "1000" ms
      And I switch to "1" browser tab
      And I wait until read page is fully loaded
    Then I should be on "Read" page

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
      And I wait until "Document Metadata Info" is visible
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "pubvol" with value "<metadataValue>"
    When I close browser tab

    Examples:
      | secondDropdownValue          | citationTitle   | citationSample | searchTerm | docTitle1                                                                                                                                                                                                                                                         | docTitle2                                                                                                                                                                                                                                                                                                      | metadataValue |
      | CFTC Staff Letters           | CFTC Letter No. | Example: 14-05 | 16-75      | Commodity Futures Releases, Decisions and Interpretations, Commodity Futures Trading Commission, CFTC Staff Advisory No. 16-75 [Practical Application of No-Action Letter No. 16-68 Regarding Investments in Money Market Mutual Funds], ¶33,889, (Oct. 18, 2016) | Commodity Futures Law Reporter, Commodity Futures Trading Commission, CFTC Staff Advisory No. 16-75 [Practical Application of No-Action Letter No. 16-68 Regarding Investments in Money Market Mutual Funds], ¶33,889, (Oct. 18, 2016)                                                                         | cfn01         |
      | Financial Reporting Releases | FRR No.         | Example: 80A   | 84         | Federal Securities Law Reporter, Securities and Exchange Commission, RELEASE NO. 84. Securities Act Release No. 9616. Investment Advisers Act Release No. 3879. Investment Company Act Release No. 31166., (Jul. 24, 2014)                                        | Federal Securities Law Reporter, Securities and Exchange Commission, Money Market Fund Reform; Amendments to Form PF. Securities Act Release No. 9616. Investment Advisers Act Release No. 3879. Investment Company Act Release No. 29497. Financial Reporting Release No. 84. July 23, 2014., (Jul. 23, 2014) | sec01         |


  @LB_regression
  @jama(CH-TC-4844)
  @jira(CU-19799)
  @component(Citation_Search)
  Scenario: Verify that Citation Search is displayed in History menu
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"

    When I wait "5000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Acts & Statutes" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "2000" ms
    Then Text of the "2nd" element of "Type Dropdowns In Citation Search Overlay" should equal "Select"

    When I wait "2000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Securities Act of 1933" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
      And I wait "2000" ms
    Then I should see "Format Field In Citation Search Overlay"
      And Text of "Format Field In Citation Search Overlay Title" should equal "Securities Act of 1933 §"
      And Text of "Format Field In Citation Search Overlay Sample" should equal "Example: 27(a)(3)"

    When I type "27(a)(3)" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "2000" ms
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And I wait until results page is fully loaded

    When I remember "Number Of Results" value as "numberOfResults"
      And I click "Home Link"
    Then I should be on "Home" page

    When I click "History"
    Then Text of the "1st" element of "History Items No Time" should equal "CITATION SEARCH: Securities Act of..."

    When I click at the "1st" element of "History Items No Time" collection
      And I remember "Number Of Results" value as "numberOfResultsAfterAccessingFromHistory"
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should see "Citation Search: Securities Act of 1933 §27(a)(3)" text
      And Value remembered as "numberOfResults" should be equal to the value remembered as "numberOfResultsAfterAccessingFromHistory"

  @LB_regression
  @jama(CH-TC-4844)
  @jira(CU-19799)
  @component(Citation_Search)
  Scenario: Verify that Citation Search is displayed in Session Navigator
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"

    When I wait "5000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Acts & Statutes" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "2000" ms
    Then Text of the "2nd" element of "Type Dropdowns In Citation Search Overlay" should equal "Select"

    When I wait "2000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Securities Act of 1933" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
      And I wait "2000" ms
    Then I should see "Format Field In Citation Search Overlay"
      And Text of "Format Field In Citation Search Overlay Title" should equal "Securities Act of 1933 §"
      And Text of "Format Field In Citation Search Overlay Sample" should equal "Example: 27(a)(3)"

    When I type "27(a)(3)" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "3000" ms
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And I wait until results page is fully loaded

    When I remember "Number Of Results" value as "numberOfResults"
      And I click "Home Link"
    Then I should be on "Home" page

    When I click "Session Navigator"
      And I click at the "2nd" element of "Indicators" collection
    Then Text of the "3rd" element of "All Items" should equal "CITATION SEARCH: Securities Act of 1933 §27(a)(3)"

    When I click at the "3rd" element of "All Items" collection
      And I remember "Number Of Results" value as "numberOfResultsAfterAccessingFromSessionNav"
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should see "Citation Search: Securities Act of 1933 §27(a)(3)" text
      And Value remembered as "numberOfResults" should be equal to the value remembered as "numberOfResultsAfterAccessingFromSessionNav"


  @LB_regression
  @jama(CH-TC-4836)
  @jira(CU-19790)
  @component(Citation_Search)
  Scenario Outline: Verify that user can perform citation search for 'Acts & Statutes' type
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"

    When I wait "5000" ms
      And I wait until "1st" element of "Type Dropdowns In Citation Search Overlay" is visible
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Acts & Statutes" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "2000" ms
    Then Text of the "2nd" element of "Type Dropdowns In Citation Search Overlay" should equal "Select"

    When I wait "2000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
      And I should see the following lines in "Type Dropdown In Citation Search Overlay Values":
       | - Select -                                 |
       | Securities Act of 1933                     |
       | Securities Exchange Act of 1934            |
       | Trust Indenture Act of 1939                |
       | Investment Company Act of 1940             |
       | Investment Advisers Act of 1940            |
       | Securities Investor Protection Act of 1970 |
       | Sarbanes-Oxley Act of 2002                 |
       | Dodd-Frank Act of 2010                     |
       | Commodity Exchange Act                     |
       | 15 U.S. Code                               |

    When I click "<secondDropdownValue>" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
      And I wait "2000" ms
    Then I should see "Format Field In Citation Search Overlay"
      And Text of "Format Field In Citation Search Overlay Title" should equal "<citationTitle>"
      And Text of "Format Field In Citation Search Overlay Sample" should equal "<citationSample>"

    When I type "<searchTerm>" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "3000" ms
    Then I should be on "Read" page
      And I wait until read page is fully loaded
      And Text of "Document Title" should contain "<docTitle>"

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
      And I wait until "Document Metadata Info" is visible
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "pubvol" with value "<metadataValue>"

    Examples:
      | secondDropdownValue                        | citationTitle                                | citationSample        | searchTerm | docTitle                                                                                          | metadataValue |
      | Securities Act of 1933                     | Securities Act of 1933 §                     | Example: 27(a)(3)     | 23         | 1933 Securities Act Sec. 23,[15 USC 77w] UNLAWFUL REPRESENTATIONS                                 | sec01         |
      | Securities Exchange Act of 1934            | Securities Exchange Act of 1934 §            | Example: 10B(a)(2)(A) | 30A        | 1934 Securities Exchange Act Sec. 30A,Prohibition                                                 | sec01         |
      | Trust Indenture Act of 1939                | Trust Indenture Act of 1939 §                | Example: 310(a)(1)    | 301        | 1939 Trust Indenture Act Sec. 301,[15 USC 77aaa] SHORT TITLE                                      | sec01         |
      | Investment Company Act of 1940             | Investment Company Act of 1940 §             | Example: 6(a)(2)(B)   | 39         | 1940 Investment Company Act Sec. 39,[15 USC 80a-38] RULES AND REGULATIONS; PROCEDURE FOR ISSUANCE | sec01         |
      | Securities Investor Protection Act of 1970 | Securities Investor Protection Act of 1970 § | Example: 13(c)(1)     | 1(a)       | 1970 Securities Investor Protection Act Sec. 1,[15 USC 78aaa] Short Title, Etc.                   | sec01         |
      | Sarbanes-Oxley Act of 2002                 | Sarbanes-Oxley Act of 2002 §                 | Example: 302(a)(4)(A) | 2(a)(2)    | 2002 Sarbanes Oxley Act Sec. 2,[15 USC 7201] [15 USC 78c] DEFINITIONS                             | sec01         |
      | Dodd-Frank Act of 2010                     | Dodd-Frank Act of 2010 §                     | Example: 802(a)(4)(B) | 722(h)     | 2010 Dodd-Frank Act Sec. 722,JURISDICTION                                                         | sec01         |
      | Commodity Exchange Act                     | Commodity Exchange Act §                     | Example: 5g           | 5g         | Sec. 5g. [7 USC §7b-2] Privacy                                                                    | cfl01         |
      | 15 U.S. Code                               | 15 USC §                                     | Example: 77z-1(a)(3)  | 77b(a)(2)  | 1933 Securities Act Sec. 2(a)(2),[15 USC 77b(a)(2)] [Person]                                      | sec01         |

  @LB_regression
  @jama(CH-TC-4836)
  @jira(CU-19790)
  @component(Citation_Search)
  Scenario: Verify that user can perform citation search for 'Acts & Statutes' type - example 1
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"

    When I wait "3000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Acts & Statutes" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "2000" ms
    Then Text of the "2nd" element of "Type Dropdowns In Citation Search Overlay" should equal "Select"

    When I wait "2000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
      And I should see the following lines in "Type Dropdown In Citation Search Overlay Values":
        | - Select -                                 |
        | Securities Act of 1933                     |
        | Securities Exchange Act of 1934            |
        | Trust Indenture Act of 1939                |
        | Investment Company Act of 1940             |
        | Investment Advisers Act of 1940            |
        | Securities Investor Protection Act of 1970 |
        | Sarbanes-Oxley Act of 2002                 |
        | Dodd-Frank Act of 2010                     |
        | Commodity Exchange Act                     |
        | 15 U.S. Code                               |

    When I click "Commodity Exchange Act" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
      And I wait "2000" ms
    Then I should see "Format Field In Citation Search Overlay"
      And Text of "Format Field In Citation Search Overlay Title" should equal "Commodity Exchange Act §"
      And Text of "Format Field In Citation Search Overlay Sample" should equal "Example: 5g"

    When I type "12" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "2000" ms
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should see "CITATION MATCHES" text
      And I should see "Citation Search: Commodity Exchange Act  §12" text
      And I should not see "Search Within Query"
      And I should not see "Search Input"
      And I should not see "Refine Search Scope Link"
      And I should not see "Save Search Button"
      And I should not see "Sort by menu"
      And I should not see a collection of "Filter Items"
      And I should see "Commodity Futures Law Reporter, Sec. 12. [7 USC §16] Commission Operations" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 12, [Cooperation with Other Agencies]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 12, [Investigative Assistance to Foreign Futures Authorities]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 12, [Computerized Futures Trading]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 12, [Employment of investigators, experts, Administrative Law Judges, consultants, clerks, and other personnel; contracts ]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 12, [Expenses]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 12, [Appropriations]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 12, [Relation to Other Law, Departments, or Agencies]" in "Citation Match Document Titles"

    When I click "Commodity Futures Law Reporter, Sec. 12. [7 USC §16] Commission Operations" at "Citation Match Document Titles"
      And I wait "1000" ms
      And I switch to "1" browser tab
      And I wait until read page is fully loaded
    Then I should be on "Read" page
      And Text of "Document Title" should contain "Sec. 12. [7 USC §16] Commission Operations"

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
      And I wait until "Document Metadata Info" is visible
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "pubvol" with value "cfl01"
    When I close browser tab

  @LB_regression
  @jama(CH-TC-4836)
  @jira(CU-19790)
  @component(Citation_Search)
  Scenario: Verify that user can perform citation search for 'Acts & Statutes' type - example 2
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"

    When I wait "3000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Acts & Statutes" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "2000" ms
    Then Text of the "2nd" element of "Type Dropdowns In Citation Search Overlay" should equal "Select"

    When I wait "2000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
      And I should see the following lines in "Type Dropdown In Citation Search Overlay Values":
        | - Select -                                 |
        | Securities Act of 1933                     |
        | Securities Exchange Act of 1934            |
        | Trust Indenture Act of 1939                |
        | Investment Company Act of 1940             |
        | Investment Advisers Act of 1940            |
        | Securities Investor Protection Act of 1970 |
        | Sarbanes-Oxley Act of 2002                 |
        | Dodd-Frank Act of 2010                     |
        | Commodity Exchange Act                     |
        | 15 U.S. Code                               |

    When I click "Commodity Exchange Act" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
      And I wait "2000" ms
    Then I should see "Format Field In Citation Search Overlay"
      And Text of "Format Field In Citation Search Overlay Title" should equal "Commodity Exchange Act §"
      And Text of "Format Field In Citation Search Overlay Sample" should equal "Example: 5g"

    When I type "4a" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "2000" ms
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should see "CITATION MATCHES" text
      And I should see "Citation Search: Commodity Exchange Act  §4a" text
      And I should not see "Search Within Query"
      And I should not see "Search Input"
      And I should not see "Refine Search Scope Link"
      And I should not see "Save Search Button"
      And I should not see "Sort by menu"
      And I should not see a collection of "Filter Items"
      And I should see "Commodity Futures Law Reporter, Sec. 4a. [7 USC §6a] Excessive Speculation" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 4a, [Exemption for Hedging Transactions]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 4a, [Applicability of Section 4a to Futures Commission Merchants and Floor Brokers]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 4a, [Limits on Trading]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 4a, [Arbitrage]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 4a, [EXCESSIVE SPECULATION—TRADING AND POSITION LIMITS—ARBITRAGE]" in "Citation Match Document Titles"
      And I should see "Commodity Futures Law Reporter, Sec. 4a, [Exceeding of Speculative Limit Prohibited]" in "Citation Match Document Titles"

    When I click "Commodity Futures Law Reporter, Sec. 4a. [7 USC §6a] Excessive Speculation" at "Citation Match Document Titles"
      And I wait "1000" ms
      And I switch to "1" browser tab
      And I wait until read page is fully loaded
    Then I should be on "Read" page
      And Text of "Document Title" should contain "sec. 4a. [7 usc §6a] excessive speculation"

    When I scroll to "Show Metadata Button" element
      And I click "Show Metadata Button"
      And I wait until "Document Metadata Info" is visible
    Then I should see "Document Metadata Info"
      And Document metadata should contain parameter "pubvol" with value "cfl01"
    When I close browser tab

  @LB_regression
  @jama(CH-TC-4841)
  @jira(CU-19795)
  @component(Citation_Search)
  Scenario: Verify 'Search Information' overlay for Citation Search Builder results
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - Federal & International" at "All Items"
    Then I should be on "home/SecuritiesFederal" page

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"
      And "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Reporters" at "Type Dropdown In Citation Search Overlay Values"
    Then "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Federal Securities Law Reporter" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is present
    Then I should see "Format Field In Citation Search Overlay"
      And "Search Button In Citation Search Overlay" should be disabled

    When I wait "2000" ms
      And I type "2706" in "Format Field In Citation Search Overlay"
    Then "Search Button In Citation Search Overlay" should be enabled

    When I click "Search Button In Citation Search Overlay"
      And I wait "2000" ms
    Then I should be on "Results" page
      And Number of "Documents List" elements should be greater than "0"
      And I should see "CITATION MATCHES" text

    When I click "Search Information Icon"
    Then I should see "Search Information Popup"
      And Text of "Search Information Popup Pre-Search Selections Practice Area" should equal "Practice Area: Securities - Federal & International"
      And Text of "Search Information Popup Pre-Search Selections Citation Search" should equal "Citation Search: Fed. Sec. L. Rep. ¶2706"

  @LB_regression
  @jama(CH-TC-4848)
  @jira(CU-19820)
  @component(Citation_Search)
  Scenario: Verify that 'Citation Search' button is NOT displayed if user has no subscription on sec01 publication
    Given I am on "Login" page
      And I wait until login page is fully loaded
      And I type "CitationT.no.sec01@wk.com" in "User ID"
      And I type "password" in "Password"
      And I click "LOG IN"
      And I wait until page title is "Cheetah"
    Then I should be on "Home" page
      And I should not see "Citation Search Button"

  @LB_regression
  @jama(CH-TC-4835)
  @jira(CU-19788)
  @component(Citation_Search)
  Scenario Outline: Verify that 'Citation Search' builder is displayed on 'Securities - Federal & International'/'Securities-All' PA
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "<PA>" at "All Items"
    Then I should be on "Home" page
      And I should see "Citation Search Button"

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"
      And I should see "Search Button In Citation Search Overlay"
      And I should see "Popup Cancel Button"
      And I should see "Type Dropdowns In Citation Search Overlay"
      And I wait "5000" ms
      And I wait until "1st" element of "Type Dropdowns In Citation Search Overlay" is present
      And Text of the "1st" element of "Citation Search Category Titles" should equal "Practice Area"
      And Text of the "2nd" element of "Citation Search Category Titles" should equal "Jurisdiction"
      And Text of the "3rd" element of "Citation Search Category Titles" should equal "Type"
      And Text of the "1st" element of "Citation Search Titles" should equal "<PA>"
      And Text of the "2nd" element of "Citation Search Titles" should equal "Federal"
      And Text of the "3rd" element of "Citation Search Titles" should equal "- Select -"
      And Text of the "1st" element of "Type Dropdowns In Citation Search Overlay" should equal "- Select -"

    When I click at the "1st" element of "Type Dropdowns In Citation Search Overlay" collection
    Then I should see "Acts & Statutes" in "Type Dropdown In Citation Search Overlay Values"
      And I should see "Agency Materials" in "Type Dropdown In Citation Search Overlay Values"
      And I should see "Forms & Schedules" in "Type Dropdown In Citation Search Overlay Values"
      And I should see "Rules & Regulations" in "Type Dropdown In Citation Search Overlay Values"
      And I should see "Reporters" in "Type Dropdown In Citation Search Overlay Values"

    When I click "Popup Cancel Button"
    Then I should not see "Citation Search Overlay"

    Examples:
    |PA                                  |
    |Securities - All                    |
    |Securities - Federal & International|

  @LB_regression_P2
  @jama(CH-TC-4949)
  @jira(CU-20244)
  @component(Major_Citation_Search_Builder_Federal_Securities)
  Scenario: Verify that Cheetah DA is displayed in Title Bar if document does not come from Federal Securities OR Commodity Futures Law Reporter DA's
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - All" at "All Items"
    Then I should be on "Home" page
      And I should see "Citation Search Button"

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"
      And I should see "Type Dropdowns In Citation Search Overlay"
    When I wait "5000" ms
      And I wait until "1st" element of "Type Dropdowns In Citation Search Overlay" is present

    When I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
    When I click "Acts & Statutes" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "3000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"

    When I click "Trust Indenture Act of 1939" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is visible
    When I type "301" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "4000" ms
    Then Currently I am on "Result" page
    Then Text of "Citation Lookup Title" should contain "Trust Indenture Act"

  @LB_regression_P2
  @jama(CH-TC-4975)
  @jira(CU-20384)
  @component(Major_Citation_Search)
  Scenario: Verify that 'Citation Search' overlay does not include 'Laws' jurisdiction
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - All" at "All Items"
      And I wait until "SECURITIES - ALL" text is present in "Session Navigator Tab"
    Then I should be on "Home" page

    When I click "Citation Search Button"
      And I wait "1000" ms
    Then I should see "Citation Search Overlay"

    When I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
      And I should see "Federal Securities" in "Type Dropdown In Citation Search Overlay Values"
      And I should see "Securities: Corporation Law and Governance" in "Type Dropdown In Citation Search Overlay Values"
      And I should see "State Securities" in "Type Dropdown In Citation Search Overlay Values"

  @LB_regression_P2
  @jama(CH-TC-4981)
  @jira(CU-20392)
  @component(Major_Citation_Search)
  Scenario: Verify that 'Post-search' section is not displayed on the 'Search information' overlay when citation-based search performed from the 'Citation Lookup' box
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Tax - All" at "All Items"
    Then I should be on "Home" page
      And I should see "Citation Lookup Input Field"
    When I type "101" in "Citation Lookup Input Field"
      And I wait until "Citation Lookup Go Button" is clickable
      And I click "Citation Lookup Go Button"
    Then I should be on "Result" page
    When I click "Info Button"
    Then I should see "Search Information" popup
      And Text of "Search Information Popup Pre-Search Selections Practice Area" should contain "Practice Area: Tax - All"
      And Text of "Search Information Popup Pre-Search Selections Citation Search" should contain "Citation Lookup: 101"
      And I should not see "Search Information Popup None Post-Search Selections"
      And I should not see "Search Information Popup Post-Search Selections"

  @LB_regression_P2
  @jama(CH-TC-4982)
  @jira(CU-20394)
  @component(Major_Citation_Search)
  Scenario: Verify that 'Post-search' section is not displayed on the 'Search information' overlay when citation-based search performed from the 'Citation Search' overlay ('Securities All' PA)
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "Securities - All" at "All Items"
    Then I should be on "Home" page
      And I should see "Citation Search Button"

    When I click "Citation Search Button"
    Then I should see "Citation Search Overlay"
      And I should see "Type Dropdowns In Citation Search Overlay"
    When I wait "5000" ms
    When I wait until "1st" element of "Type Dropdowns In Citation Search Overlay" is present

    When I click at the "1st" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
    When I click "Federal Securities" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "3000" ms
      And I click at the "2nd" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
    When I click "Reporters" at "Type Dropdown In Citation Search Overlay Values"
      And I wait "3000" ms
      And I click at the "3" element of "Type Dropdowns In Citation Search Overlay"
    Then I should see a collection of "Type Dropdown In Citation Search Overlay Values"
    When I click "Federal Securities Law Reporter" at "Type Dropdown In Citation Search Overlay Values"
      And I wait until "Format Field In Citation Search Overlay" is visible
    When I type "2706" in "Format Field In Citation Search Overlay"
      And I click "Search Button In Citation Search Overlay"
      And I wait "4000" ms
      And I should be on "Result" page
    Then Text of "Citation Lookup Title" should contain "Fed. Sec. L. Rep. ¶2706"

    When I click "Info Button"
    Then I should see "Search Information" popup
      And Text of "Search Information Popup Pre-Search Selections Practice Area" should contain "Practice Area: Securities - All"
      And Text of "Search Information Popup Pre-Search Selections Citation Search" should contain "Citation Search: Fed. Sec. L. Rep. ¶2706"
      And I should not see "Search Information Popup None Post-Search Selections"
      And I should not see "Search Information Popup Post-Search Selections"

  @LB_regression_P2
  @jama(CH-TC-4974)
  @jira(CU-20400)
  @component(Major_Citation_Search)
  Scenario: Verify that unnecessary additional bar didn't appears on SRL for '17 CFR 242.301(b)(6)(ii)' and '15 U.S.C. Sec. 1011' search terms after sorting the SRL by Doctype
    Given I am on "Home" page
    When I click "Session Navigator"
      And I click "All Content" at "All Items"
    Then I should be on "Home" page

    When I click "Refine Search Scope Link"
      And I check "1st" element of "Always Apply Thesaurus Checkboxes"
      And I type "17 CFR 242.301(b)(6)(ii)" in "Search Input in Pre Search Panel"
      And I wait until "Search in PreSearch" is clickable
      And I click "Search in PreSearch"
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And I should see "17 CFR 242.301(b)(6)(ii)" text
      And I should see "Sort by menu"

    When I click "Sort by menu"
      And I click "Document Type" link
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And Text of "Sort by menu" should equal "Document type"
      And I should see a collection of "Cluster Header"

    When I click "See All Agency Materials" at "See All Results Buttons"
      And I wait until results page is fully loaded
    Then Text of "Sort by menu" should equal "Document type"

    When I wait until results page is fully loaded
    Then I should be on "Results" page
    And I should see "Agency Materials" in "Post Search Panel Filter"

    When I click "Hide Filter Panel Button"
    Then I should see "Agency Materials" in "Facet Selected Types Items"
      And Text of the "2nd" element of "Facet Types Names" should be bold
      And Each element of collection of "Facet Subtypes Names" should be bold
      And Each element of collection of "Facet Subtypes Checkboxes" should be checked
      And I should see a collection of "Cluster Header"
    When I click "Hide Filter Panel Button"
      And I scroll down whole page
    Then Number of "Cluster Header" elements should equal "1"

    When I wait until "25" element of "Documents List" is visible
      And I click "Home Link"
    Then I should be on "Home" page

    When I click "Session Navigator"
      And I click "All Content" at "All Items"
    Then I should be on "Home" page

    When I click "Refine Search Scope Link"
      And I type "15 U.S.C. Sec. 1011" in "Search Input in Pre Search Panel"
      And I wait until "Search in PreSearch" is clickable
      And I click "Search in PreSearch"
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And I should see "15 U.S.C. Sec. 1011" text
      And I should see "Sort by menu"

    When I click "Sort by menu"
      And I click "Document Type" link
      And I wait until results page is fully loaded
    Then I should be on "Results" page
      And Text of "Sort by menu" should equal "Document type"
      And I should see a collection of "Cluster Header"

    When I click "See All Secondary (Analytical) Materials" at "See All Results Buttons"
      And I wait until results page is fully loaded
    Then Text of "Sort by menu" should equal "Document type"
    When I wait until results page is fully loaded
    Then I should be on "Results" page
      And I should see "Secondary (Analytical) Materials" in "Post Search Panel Filter"

    When I click "Hide Filter Panel Button"
    Then I should see "Secondary (Analytical) Materials" in "Facet Selected Types Items"
      And Text of the "1st" element of "Facet Types Names" should be bold
      And Each element of collection of "Facet Subtypes Names" should be bold
      And Each element of collection of "Facet Subtypes Checkboxes" should be checked
      And I should see a collection of "Cluster Header"

    When I click "Hide Filter Panel Button"
      And I scroll down whole page
    Then Number of "Cluster Header" elements should equal "1"

    When I wait until "25" element of "Documents List" is visible
      And I click "Home Link"
    Then I should be on "Home" page