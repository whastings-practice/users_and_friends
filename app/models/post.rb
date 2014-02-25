# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  title      :string(255)      not null
#  body       :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Post < ActiveRecord::Base
  validates :user_id, :title, :body, presence: true


  belongs_to :user

  has_many(
    :links,
    dependent: :destroy,
    inverse_of: :post
  )

  has_many(
    :shares,
    dependent: :destroy,
    inverse_of: :post,
    class_name: "PostShare"
  )

  has_many :friend_circles, through: :shares, source: :friend_circle

end
