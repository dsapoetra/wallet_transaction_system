class RemoveTransactionTypeFromWalletTransactions < ActiveRecord::Migration[6.1]
  def change
    remove_column :wallet_transactions, :transaction_type, :string
  end
end
