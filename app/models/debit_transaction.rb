# app/models/debit_transaction.rb
class DebitTransaction < WalletTransaction
    before_validation :ensure_negative_amount
    validate :sufficient_balance
  
    private
  
    def ensure_negative_amount
      self.amount = -amount.abs
    end
  
    def sufficient_balance
      errors.add(:amount, "Insufficient balance") if wallet.balance < amount.abs
    end
  end
  