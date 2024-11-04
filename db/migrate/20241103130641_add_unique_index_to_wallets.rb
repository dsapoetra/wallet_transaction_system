class AddUniqueIndexToWallets < ActiveRecord::Migration[6.1]
  def change
    # Adding a composite unique index on owner_id and owner_type
    add_index :wallets, [:owner_id, :owner_type], unique: true
  end
end