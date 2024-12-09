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
  before_action :created_token
  validates :name, presence: true
  validatesx :email, presence: true
=begin   def created_token
    GenerateToken.generate
  end
=end
end
