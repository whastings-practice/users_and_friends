# == Schema Information
#
# Table name: post_shares
#
#  id               :integer          not null, primary key
#  post_id          :integer          not null
#  friend_circle_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class PostShare < ActiveRecord::Base

  validates :post, :friend_circle_id, presence: true


  belongs_to(
   :post,
   inverse_of: :shares
  )
  belongs_to :friend_circle


end
