class SessionController < ApplicationController
  skip_before_action :authenticate!, only: [ :create, :index ]

  def index
    @user = User.all
    render json: @user
  end

  def create
    @user = User.authenticate(login_params)
    unless @user
        render json: {
          error: { email: [ "credenciales no validas" ] },
          status: :unauthorized
        }
        return
    end
    render json: authenticate_payload
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def authenticate_payload
    return { errors: "User not found" } if @user.nil?

    token = JsonWebToken.encode(@user.jwt_payload)
    time = Time.zone.now + 24.hours.to_i

    {
      access: token,
      exp: time.strftime("%m-%d-%Y %H:%M"),
      user: @user.as_json
    }
  end
end
