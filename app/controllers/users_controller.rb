class UsersController < ApplicationController
  skip_before_action :authorize, only: :create

  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
    # if user.valid?
    #   session[:user_id] = user.id
    #   render json: user, status: :created
    # else
    #   render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    # end
  end

  def show
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      render json: user, status: :ok
    else  
      render json: { error: "Please sign in to view this content" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

end
