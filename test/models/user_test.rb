require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "cannot create an empty user" do
    user = User.new
    assert_not user.valid?
  end

  test "cannot create user without uid" do
    user = User.new(name: "Valentino", email: "vale@catemail.com", provider: "github")
    assert_not user.valid?
  end

  test "cannot create user without provider" do
    user1 = User.new(name: "Valentino", email: "vale@catemail.com", uid: 123)
    assert_not user1.valid?
  end

  test "the user will not be valid without an email" do
    user = User.new(name: "Joaquin")
    assert_not user.valid?
  end

  test "should create a user when all required fields are provided" do
    user = users(:valentino)
    assert user.valid?
  end
end
