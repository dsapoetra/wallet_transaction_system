class AddSourceAndTargetWalletsToWalletTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :wallet_transactions, :source_wallet_id, :integer, foreign_key: { to_table: :wallets }
    add_column :wallet_transactions, :target_wallet_id, :integer, foreign_key: { to_table: :wallets }
  end
end
