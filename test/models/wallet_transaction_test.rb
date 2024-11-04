require 'test_helper'

class WalletTransactionTest < ActiveSupport::TestCase
  # Setup method to initialize any necessary data before tests
  def setup
    @wallet = Wallet.create!(balance: 100.0, owner: User.create!(username: "test", password: "password123"))
    @credit_transaction = WalletTransaction.new(amount: 50.0, wallet: @wallet, transaction_type: "credit")
    @debit_transaction = WalletTransaction.new(amount: -25.0, wallet: @wallet, transaction_type: "debit")
  end

  # Test for valid credit transaction
  test "should be valid with a positive amount and credit transaction type" do
    assert @credit_transaction.valid?, "Credit transaction should be valid with a positive amount and wallet"
  end

  # Test for valid debit transaction
  test "should be valid with a negative amount and debit transaction type" do
    assert @debit_transaction.valid?, "Debit transaction should be valid with a negative amount and wallet"
  end

  # Test for invalid transaction without associated wallet
  test "should be invalid without a wallet" do
    @credit_transaction.wallet = nil
    assert_not @credit_transaction.valid?, "Transaction should be invalid without an associated wallet"
  end

  # Test to reject negative amount for credit transaction
  test "should be invalid with a negative amount for credit transaction" do
    @credit_transaction.amount = -50.0
    assert_not @credit_transaction.valid?, "Credit transaction should be invalid with a negative amount"
  end

  # Test to reject positive amount for debit transaction
  test "should be invalid with a positive amount for debit transaction" do
    @debit_transaction.amount = 50.0
    assert_not @debit_transaction.valid?, "Debit transaction should be invalid with a positive amount"
  end
end
