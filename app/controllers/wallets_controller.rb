class WalletsController < ApplicationController
    before_action :authorize_request  # Ensure JWT-based authorization
  
    # Action to create a wallet for the current user
    def create
      begin
        wallet = Wallet.new(wallet_params)
        wallet.owner = @current_user  # Set the owner of the wallet to the current user
  
        if wallet.save
          render json: { wallet: wallet, message: 'Wallet created successfully' }, status: :created
        else
          render json: { error: wallet.errors.full_messages }, status: :unprocessable_entity
        end
      rescue ActiveRecord::RecordNotUnique
        render json: { error: 'User can only have one wallet' }, status: :unprocessable_entity
      end
    end
  
    # Action to retrieve the current user's wallet
    def mine
      wallet = Wallet.find_by(owner: @current_user)
  
      if wallet
        render json: { wallet: wallet }, status: :ok
      else
        render json: { error: 'Wallet not found' }, status: :not_found
      end
    end
  
    private
  
    # Strong parameters for wallet creation
    def wallet_params
      params.require(:wallet).permit(:balance)
    end
  end
  