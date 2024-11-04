# app/models/wallet_transaction.rb
class WalletTransaction < ApplicationRecord
  # Associations
  belongs_to :wallet

  enum transaction_type: { credit: 'credit', debit: 'debit', transfer: 'transfer' }

  # Validations
  validates :amount, presence: true, numericality: { other_than: 0 }
  validates :transaction_type, presence: true
  validates :wallet, presence: true

  validate :validate_amount_based_on_transaction_type

  private

  def validate_amount_based_on_transaction_type
    if credit? && amount < 0
      errors.add(:amount, "must be positive for credit transactions")
    elsif debit? && amount > 0
      errors.add(:amount, "must be negative for debit transactions")
    end
  end
end
