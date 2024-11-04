require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # Setup method to create a user
  def setup
    @user = User.create!(username: "test", password: "password123")
    
    # Temporarily redefine `authorize_request` in UsersController
    UsersController.class_eval do
      alias_method :original_authorize_request, :authorize_request
      def authorize_request; true; end
    end
  end

  # Clean up after tests
  def teardown
    # Restore the original method to avoid side effects
    UsersController.class_eval do
      # alias_method :authorize_request, :original_authorize_request
      remove_method :original_authorize_request
    end
  end

  # Test for index action
  test "should get index" do
    get users_url
    assert_response :success

    # Verify the JSON response structure
    json_response = JSON.parse(@response.body)
    assert json_response.is_a?(Array), "Expected JSON response to be an array"
    assert json_response.first.key?("id"), "Expected user JSON to include id"
    assert json_response.first.key?("username"), "Expected user JSON to include username"
  end
end
