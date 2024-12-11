# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  name          :string(255)
#  email         :string(255)
#  authenticated :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher


  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  validates :name, presence: true
  validates :email, presence: true

  before_create :initialize_jti

  def self.authenticate!(params)
    user  = User.find_for_authentication(email: params[:email])
    user&.valid_password?(params[:password]) ? user : nil
  end
  def jwt_payload
    { user_id: self.id, jti: self.jti }
  end

  def generate_password_token!
    generated_token = generate_token
    self.reset_password_token = generated_token
    self.reset_password_sent_at = Time.now.utc
    save!
  end


  def password_token_valid?
    (reset_password_sent_at + 1.hour) > Time.now.utc
  end

private

def initialize_jti
  self.jti ||= SecureRandom.uuid
end
  def generate_token
    SecureRandom.hex(20)
  end
end
