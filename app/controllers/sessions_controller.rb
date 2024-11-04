# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])

    # Authenticate user and return JWT token if authentication succeeds
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, exp: 24.hours.from_now.strftime("%m-%d-%Y %H:%M") }, status: :ok
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end
end
