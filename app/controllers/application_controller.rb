class ApplicationController < ActionController::Base
  before_action :basic_auth,  if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  private

  def production?
    Rails.env.production?
  end

  def basic_auth # Ruby on RailsでBasic認証を実装するためのメソッド[authenticate_or_request_with_http_basic]
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,
       :family_name, :first_name, :family_name_kana, :first_name_kana,
       :birthday_year, :birthday_month, :birthday_day,
       :post_code, :prefecture_id, :city, :house_number, :building_name])
  end
end



