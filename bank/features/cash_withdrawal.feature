Feature: Cash Withdrawal
  Scenario Outline: Successful withdrawal from an account in credit
    Given I have deposited <deposit> in my account
    When I request <withdraw>
    Then <withdraw> should be dispensed
    And  balance in account should be <balance>

    Examples:
        | deposit | withdraw |   balance |
        |   100   |   20     |     80    |
        |   1000  |   200    |     800   |