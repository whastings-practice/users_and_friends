# == Schema Information
#
# Table name: user_reset_passwords
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  auth_token :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class UserResetPassword < ActiveRecord::Base
  before_validation :create_reset_token
  validates :user_id, :auth_token, :presence => true

  belongs_to :user

  TOKEN_EXPIRATION = 2.days.ago

  def create_reset_token
    self.auth_token = SecureRandom::urlsafe_base64(32)
  end

  def expired?
    self.created_at < TOKEN_EXPIRATION
  end

end
