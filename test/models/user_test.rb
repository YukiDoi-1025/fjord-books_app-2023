# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test '#name_or_email' do
    user = users(:no_name)
    assert_equal 'no_name@example.com', user.name_or_email

    alice = users(:alice)
    assert_equal 'alice', alice.name_or_email
  end
end
