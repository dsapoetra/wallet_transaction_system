class AddTransactionTypeToWalletTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :wallet_transactions, :transaction_type, :string
  end
end
