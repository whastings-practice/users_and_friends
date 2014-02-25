module FriendCirclesHelper

  def friend_circle_form_url(circle)
    circle.persisted? ? friend_circle_url(circle) : friend_circles_url
  end

  def friend_circle_submit_text(circle)
    circle.persisted? ? "Update Friend Circle" : "Create Friend Circle"
  end

  def friend_checked(friends, user)
    friends.include?(user.id) ? "checked" : ""
  end
end
