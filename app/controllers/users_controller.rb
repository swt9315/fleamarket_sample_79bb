class UsersController < ApplicationController
  before_action :user

  private
  
  def set_user
    @user = User.find(params[:id])
  end
end
