require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @micropost = @user.microposts.build(content: "first content")
    # @micropost = Micropost.new(content: "first content", user_id: @user.id)
  end

  test  "should be valid" do
    assert @micropost.valid?
  end
  
  test "user is should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do 
    assert_equal microposts(:most_recent), Micropost.first
  end
end
