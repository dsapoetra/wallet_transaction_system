# db/migrate/xxxxxx_add_type_to_wallet_transactions.rb
class AddTypeToWalletTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :wallet_transactions, :type, :string
  end
end
