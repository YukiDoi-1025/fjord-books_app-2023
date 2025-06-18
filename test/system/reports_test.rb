# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:one)

    visit reports_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
    assert_text 'ログインしました。'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'サンプルタイトル'
    assert_text 'これは日報のサンプルです。'
  end

  test 'update Report' do
    visit report_url(@report)
    click_on 'この日報を編集', match: :first

    fill_in 'タイトル', with: 'アップデートタイトル'
    fill_in '内容', with: 'これは更新された日報です。'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text 'アップデートタイトル'
    assert_text 'これは更新された日報です。'
  end

  test 'destroy Report' do
    visit report_url(@report)
    click_button 'この日報を削除', match: :first

    assert_text '日報が削除されました。'
    assert_text 'サンプルタイトル', count: 0
    assert_text 'アップデートタイトル', count: 0
    assert_text 'これは日報のサンプルです。', count: 0
    assert_text 'これは更新された日報です。', count: 0
  end
end
