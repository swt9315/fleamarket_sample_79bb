class ApplicationController < ActionController::Base
  before_action :basic_auth,  if: :production?
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
end