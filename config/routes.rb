Rails.application.routes.draw do
  # User Registration and Session Creation
  post 'register', to: 'registrations#create'   # Register a new user
  post 'sessions', to: 'sessions#create'        # Create session (login)

  # Wallets
  resources :wallets, only: [:create] do
    get 'mine', on: :collection  # Fetch the current user's wallet
  end

  # Wallet Transactions
  resources :wallet_transactions, only: [:create, :index] do
    collection do
      get 'list'  # List all transactions for the current user's wallet
    end
  end

  get 'stock_prices/price_all', to: 'stock_prices#price_all'
  get 'stock_prices/equities', to: 'stock_prices#equities'


  # User listing with IDs and usernames
  resources :users, only: [:index]  # List all users by ID and username (no passwords)
end
