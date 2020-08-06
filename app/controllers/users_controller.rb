class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def show
    @name = current_user.name
  end

  def edit
    user = User.find(params[:id])
  end

  def logout
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
