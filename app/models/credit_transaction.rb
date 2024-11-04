# app/models/credit_transaction.rb
class CreditTransaction < WalletTransaction
    before_validation :ensure_positive_amount
  
    private
  
    def ensure_positive_amount
      self.amount = amount.abs
    end
  end
  