class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  before_action :set_category

  EXHIBITING_STATUS = 1

  private
  def production?
    Rails.env.production?
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  protected
  def set_category
    @parents  = Category.where(ancestry: nil)
  end
end
