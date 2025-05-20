# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @user_test = users(:alice)
    @report = reports(:one)
  end

  test '#editable?' do
    assert @report.editable?(@user_test)
  end

  test '#created_on' do
    created_at = @report.created_at.to_date
    assert_equal created_at, @report.created_on
  end
end
