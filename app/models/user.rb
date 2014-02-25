# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)      not null
#  password_digest :string(255)      not null
#  session_token   :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  attr_reader :password

  before_validation :ensure_session_token
  validates :password, :length => { :minimum => 6, :allow_nil => true }
  validates :email, :password_digest, :session_token, :presence => true

  has_many :friend_circles
  has_many :friend_memberships, through: :friend_circles, source: :memberships
  has_many :friends, through: :friend_memberships, source: :friend
  has_many :posts
  has_many :post_shares
  has_many(
    :memberships,
    primary_key: :id,
    foreign_key: :friend_id,
    class_name: "FriendCircleMembership"
  )
  has_many :member_circles, through: :memberships, source: :friend_circle
  has_many(
    :posts_shared_with_user,
    through: :member_circles,
    source: :shared_posts
  )

  def self.create_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def password=(plaintext)
    @password = plaintext
    self.password_digest = BCrypt::Password.create(plaintext).to_s
  end



  def is_password?(plaintext)
    BCrypt::Password.new(self.password_digest).is_password?(plaintext)
  end


  def self.find_by_credentials(user_params)
    user = User.find_by(:email => user_params[:email])
    if user && user.is_password?(user_params[:password])
      user
    else
      nil
    end

  end

  def ensure_session_token
    self.session_token ||= self.class.create_session_token
  end

  def reset_session_token!
    self.session_token = self.class.create_session_token
    self.save!
    self.session_token
  end

end
