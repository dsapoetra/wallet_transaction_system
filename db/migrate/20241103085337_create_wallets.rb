class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.references :owner, polymorphic: true, null: false
      t.decimal :balance, null: false  # Remove default: 0.0 if it exists
      t.timestamps
    end
  end
end
