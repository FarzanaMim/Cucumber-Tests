class CashSlot
  def contents
    @contents or raise('I am empty!')
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
    account.withdraw(amount)
  end
end

class Account
  attr_accessor :balance

  def deposit(amount)
    @balance = amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end
