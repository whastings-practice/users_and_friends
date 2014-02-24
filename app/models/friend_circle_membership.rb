# == Schema Information
#
# Table name: friend_circle_memberships
#
#  id               :integer          not null, primary key
#  friend_circle_id :integer          not null
#  friend_id        :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class FriendCircleMembership < ActiveRecord::Base
  validates :friend_circle, :friend_id, presence: true

  belongs_to :friend_circle, :inverse_of => :memberships
  belongs_to(
    :friend,
    primary_key: :id,
    foreign_key: :friend_id,
    class_name: "User"
  )
end
