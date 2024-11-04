class UsersController < ApplicationController
    before_action :authorize_request  # Ensure only authenticated users can access this endpoint
  
    def index
      users = User.select(:id, :username)  # Only select id and username
      render json: users, status: :ok
    end
  end
  