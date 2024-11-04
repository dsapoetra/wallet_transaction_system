# app/models/transfer_transaction.rb
class TransferTransaction < WalletTransaction
    belongs_to :target_wallet, class_name: 'Wallet', foreign_key: 'target_wallet_id'
  
    validate :sufficient_balance, :valid_target_wallet
  
    private
  
    def sufficient_balance
      errors.add(:amount, "Insufficient balance") if wallet.balance < amount.abs
    end
  
    def valid_target_wallet
      errors.add(:target_wallet, "Invalid target wallet") if target_wallet.nil?
    end
  end
  