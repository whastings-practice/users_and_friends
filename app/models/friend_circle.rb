# == Schema Information
#
# Table name: friend_circles
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class FriendCircle < ActiveRecord::Base
  validates :user_id, :name, presence: true


  belongs_to :user

  has_many(
    :memberships,
    inverse_of: :friend_circle,
    primary_key: :id,
    foreign_key: :friend_circle_id,
    class_name: "FriendCircleMembership"
  )

  has_many :friends, :through => :memberships, :source => :friend

end
