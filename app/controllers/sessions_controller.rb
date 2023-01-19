class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_id: session_params[:user_id], password: session_params[:password])
    if @user.valid? && (@user = User.find_by(user_id: session_params[:user_id])) && @user.authenticate(session_params[:password])
      login @user
      redirect_to root_url
    else
      render :new,  status: :unprocessable_entity
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:user_id, :password)
  end
end
