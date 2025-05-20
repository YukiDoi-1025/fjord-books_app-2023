# frozen_string_literal: true

require 'test_helper'

class UsersHelperTest < ActionView::TestCase
  test 'current user name' do
    user = users(:alice)
    assert_equal 'alice', current_user_name(user)

    no_name = users(:no_name)
    assert_equal 'no_name@example.com', current_user_name(no_name)
  end
end
