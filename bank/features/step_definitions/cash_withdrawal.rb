require 'rspec/expectations'

module KnowsMyAccount
  def my_account
    @my_account ||= Account.new
  end

  def cash_slot
    @cash_slot ||= CashSlot.new
  end

  def teller
    @teller ||= Teller.new(cash_slot)
  end
end

World(KnowsMyAccount)

class CashSlot
  def contents
    @contents or raise("I am empty!")
  end

  def dispense(amount)
    @contents = amount
  end
end

class Teller
  def initialize(cash_slot)
    @cash_slot = cash_slot
  end

  def withdraw_from(account, amount)
    @cash_slot.dispense(amount)
  end
end

class Account
  attr_accessor :balance

  def deposit(amount)
    @balance = amount
  end
end

CAPTURE_CASH_AMOUNT = Transform /^\d+$/ do |number|
  number.to_i
end

Given(/^I have deposited \$(#{CAPTURE_CASH_AMOUNT}) in my account$/) do |amount|
  my_account.deposit(amount)
  expect(my_account.balance).to eq(amount)
end

When(/^I request \$(#{CAPTURE_CASH_AMOUNT})$/) do |amount|
  teller.withdraw_from(my_account, amount)
end

Then(/^\$(#{CAPTURE_CASH_AMOUNT}) should be dispensed$/) do |amount|
  expect(cash_slot.contents).to eq(amount)
end
