class WalletTransactionsController < ApplicationController
  before_action :authorize_request
  before_action :set_wallet

  def list
    transactions = @wallet.wallet_transactions.order(created_at: :desc)
    render json: transactions, status: :ok
  end

  def create
    # Dynamically find the class based on transaction type
    transaction_type = params[:transaction_type].capitalize + "Transaction"
    transaction_class = transaction_type.safe_constantize

    # Check if the class exists and inherits from WalletTransaction
    unless transaction_class && transaction_class < WalletTransaction
      render json: { error: 'Invalid transaction type' }, status: :unprocessable_entity
      return
    end

    # Initialize the transaction and explicitly set transaction_type
    transaction = transaction_class.new(transaction_params.merge(wallet: @wallet, transaction_type: params[:transaction_type]))

    if transaction.save
      render json: { message: 'Transaction successful' }, status: :ok
    else
      render json: { error: transaction.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def transaction_params
    # Ensure transaction_type is permitted
    params.permit(:amount, :source_wallet_id, :target_wallet_id, :transaction_type)
  end

  def set_wallet
    @wallet = Wallet.find_by(owner: @current_user)
    render json: { error: 'Wallet not found' }, status: :not_found unless @wallet
  end
end
