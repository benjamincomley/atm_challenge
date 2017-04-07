require 'date'
require './lib/account.rb'
require './lib/atm.rb'

class Person

attr_accessor :name, :cash, :account

  def initialize(attrs = {})
    @name = set_name(attrs[:name])
    @cash = 0
    @account = nil
  end

  def create_account
    @account = Account.new(owner: self)
  end

  def deposit(amount)
    @account.nil? ? missing_account : deposit_funds(amount)
  end

  def withdraw(arg ={})
    @account.nil? ? missing_account : withdraw_funds
  end

private

  def deposit_funds(amount)
    @cash -= amount
    @account.balance += amount
  end

  def withdraw_funds(arg)
    arg[:atm] == nil ? missing_atm : atm = arg[:atm]
    account = @account
    amount = arg[:amount]
    pin = arg[:pin]
    response = atm.withdraw(amount, pin, account)
    response[:status] == true ? increase_cash(response) : response
  end

  def increase_cash
    @cash += response[:amount]
  end

  def set_name(obj)
    obj == nil ? missing_name : @name = obj
  end

  def missing_name
    raise 'A name is required'
  end

  def missing_account
    raise 'No account present'
  end

  def missing_atm
    raise 'An ATM is required'
  end
end
