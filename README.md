
# Wallet Transaction System

The Wallet Transaction System is a Ruby on Rails API application designed to handle wallet-based financial transactions. It provides endpoints for managing wallets, creating different types of transactions (credit, debit, and transfer), and ensuring secure access through JWT authentication.

## Features

- **JWT Authentication**: Secure authentication with JSON Web Tokens (JWT).
- **Polymorphic Wallet Model**: Each user can have a wallet with a polymorphic association to allow for flexibility.
- **Transaction Types**: Supports multiple transaction types such as credit, debit, and transfer.
- **Balance Calculation**: Calculates wallet balance based on transactions.
- **Validation**: Ensures transactions are correctly validated based on type (e.g., debit transactions ensure sufficient funds).

## Installation

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd wallet_transaction_system
   ```

2. **Install Dependencies**:
   Make sure you have Ruby and Bundler installed, then run:
   ```bash
   bundle install
   ```

3. **Database Setup**:
   Set up the database by running the migrations:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. **Environment Variables**:
   - Set the `SECRET_KEY_BASE` for JWT encoding/decoding. You can generate one with:
     ```bash
     rails secret
     ```
   - Add this key to your environment variables, e.g., in `.env`:
     ```
     SECRET_KEY_BASE=<your-secret-key>
     ```

5. **Run the Server**:
   Start the Rails server:
   ```bash
   rails server
   ```

## API Endpoints

### Authentication

- **Register**: `POST /register`
  - Parameters: `username`, `password`
  - Returns: User information upon successful registration.

- **Login**: `POST /sessions`
  - Parameters: `username`, `password`
  - Returns: JWT token on successful login.

### Wallets

- **List Transactions**: `GET /wallet_transactions`
  - Requires JWT token.
  - Returns: List of all transactions for the authenticated user’s wallet.

- **Create Transaction**: `POST /wallet_transactions`
  - Parameters:
    - `amount`: Decimal
    - `transaction_type`: String (one of `credit`, `debit`, `transfer`)
    - `target_wallet_id` (for transfers)
  - Requires JWT token.
  - Returns: Success or error message based on transaction validation.

### Stock API

- **List Available Stocks**: `GET /stocks`
  - Requires JWT token.
  - Returns: List of available stocks.

- **Purchase Stock**: `POST /stocks/purchase`
  - Parameters:
    - `stock_id`: ID of the stock
    - `quantity`: Number of shares to purchase
  - Requires JWT token.
  - Returns: Confirmation of purchase or error message if validation fails.

## Models

### User

- Fields:
  - `username`: Unique identifier for the user.
  - `password_digest`: Encrypted password (handled via `has_secure_password`).

### Wallet

- Polymorphic association with User.
- **Methods**:
  - `transaction_balance`: Returns the total balance based on transactions.

### WalletTransaction

- Fields:
  - `amount`: Decimal
  - `transaction_type`: Enum (`credit`, `debit`, `transfer`)
- Validations:
  - Ensures `amount` is non-zero.
  - Custom validations for positive/negative amounts based on `transaction_type`.

### Transaction Subclasses

- **CreditTransaction**: Ensures `amount` is positive.
- **DebitTransaction**: Ensures `amount` is negative and user has sufficient balance.
- **TransferTransaction**: Checks for valid target wallet and balance.

## Testing

1. **Run All Tests**:
   ```bash
   rails test
   ```

2. **Controller Tests**: Ensure the API endpoints work as expected.
3. **Model Tests**: Test validations, associations, and custom logic.

## Usage

1. **Register** a user to create an account.
2. **Authenticate** to obtain a JWT token.
3. Use the JWT token in the `Authorization` header for all subsequent requests.
4. **Create transactions** by specifying an `amount` and `transaction_type`. For transfer transactions, specify the `target_wallet_id`.

## License

This project is open-source under the MIT License.
