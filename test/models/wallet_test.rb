require 'test_helper'

class WalletTest < ActiveSupport::TestCase
  # Setup method to initialize any necessary data before tests
  def setup
    @owner = User.create!(username: "test", password: "password123")
    @wallet = Wallet.create(balance: 100.0, owner: @owner)
  end

  # Test for the transaction_balance method
  test "transaction_balance should return the sum of wallet transactions" do
    @wallet.wallet_transactions.create!(amount: 50.0, transaction_type: "credit")
    @wallet.wallet_transactions.create!(amount: 20.0, transaction_type: "credit")
    assert_equal 70.0, @wallet.transaction_balance, "transaction_balance should be 70.0 after adding transactions"
  end
end
