# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  def setup
    @user_test = users(:alice)
    @user_unauthorized = users(:bob)
    @report = reports(:one)
  end

  test '#editable?' do
    assert @report.editable?(@user_test)
    assert_not @report.editable?(@user_unauthorized)
  end

  test '#created_on' do
    @report.created_at = Time.zone.parse('2025-5-27 12:00:00')
    assert_equal Date.parse('2025-5-27'), @report.created_on
  end
end
