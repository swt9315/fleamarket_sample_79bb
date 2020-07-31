class UsersController < ApplicationController
  before_action :user

  def index
  end

  def edit
  end

  def update
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end
end
