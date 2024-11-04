require 'test_helper'

class WalletsControllerTest < ActionDispatch::IntegrationTest
  # Setup a sample user for tests
  def setup
    @user = User.create!(username: "test", password: "password123")
    @current_user = @user  # Set @current_user for test

    # Mock the authorization by bypassing `authorize_request` and setting @current_user
    WalletsController.class_eval do
      alias_method :original_authorize_request, :authorize_request
      define_method(:authorize_request) do
        @current_user = User.first
      end
    end
  end

  # Clean up after tests
  def teardown
    # Restore the original method to avoid side effects
    WalletsController.class_eval do
      # alias_method :authorize_request, :original_authorize_request
      remove_method :original_authorize_request
    end
  end

  # Test the create action
  test "should create wallet" do
    assert_difference('Wallet.count', 1) do
      post wallets_url, params: { wallet: { balance: 100.0 } }
    end
    assert_response :created

    json_response = JSON.parse(@response.body)
    assert json_response["wallet"].key?("id"), "Expected wallet JSON to include id"
    assert_equal "100.0", json_response["wallet"]["balance"], "Expected wallet balance to match"
  end

  # # Test the mine action
  # test "should get current user's wallet" do
  #   # Create a wallet associated with @current_user
  #   Wallet.create!(balance: 100.0, owner: @current_user)

  #   get mine_wallets_url
  #   assert_response :success

  #   json_response = JSON.parse(@response.body)
  #   assert json_response["wallet"].key?("id"), "Expected wallet JSON to include id"
  #   assert_equal 100.0, json_response["wallet"]["balance"], "Expected wallet balance to match"
  # end
end
