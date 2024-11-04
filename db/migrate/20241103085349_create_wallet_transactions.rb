class CreateWalletTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :wallet_transactions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.decimal :amount, null: false
      t.string :transaction_type, null: false
      t.timestamps
    end
  end
end
