# == Schema Information
#
# Table name: links
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  title      :string(255)      not null
#  url        :string(1024)
#  created_at :datetime
#  updated_at :datetime
#

class Link < ActiveRecord::Base

  validates :post, :title, :url, presence: true

  belongs_to(
    :post,
    inverse_of: :links
  )


end
