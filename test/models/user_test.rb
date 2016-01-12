require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup    
    # @user is instance variale, so automatically avaliable in all the test
    @user = User.new(name: "example", email: "example@gmail.com",
      password: "demo123", password_confirmation: "demo123")
  end

  test "should be vaild" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name =""
    assert_not @user.valid?
    # assert @user.valid?
  end

  test "email should be present" do
    @user.email =""
    assert_not @user.valid?
  end

  test "name should not too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email address should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minumum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

end
