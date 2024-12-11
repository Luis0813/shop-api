class ApplicationController < ActionController::API
  extend ActiveSupport::Concern
    require "jwt"

  before_action :authenticate!

  def authenticate!
    header = request.headers["Authorization"]
    puts "Authorization Header: #{header}"
    jwt = header.split.last if header
    begin
      @decoded = JsonWebToken.decode(jwt)
      @current_user ||= User.find_by!(jti: @decoded[:jti])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
