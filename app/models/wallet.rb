class Wallet < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :wallet_transactions, dependent: :destroy

  # Rename to avoid conflict with the database column
  def transaction_balance
    wallet_transactions.sum(:amount)
  end
end
