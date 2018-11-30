require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should follow and unfollow a user" do
    ivan = users(:ivan)
    nick  = users(:nick)
    assert_not ivan.following?(nick)
    ivan.follow(nick)
    assert ivan.following?(nick)
    assert nick.followers.include?(ivan)
    ivan.unfollow(nick)
    assert_not ivan.following?(nick)
  end
end
