# frozen_string_literal: true

module ApplicationHelper
  # localeに応じて複数形の表記を変える
  # - 日本語の場合 => 本
  # - 英語の場合 => books
  def i18n_pluralize(word)
    I18n.locale == :ja ? word : word.pluralize
  end

  # localeに応じてエラー件数の表記を変える
  # - 日本語の場合 => 3件のエラー
  # - 英語の場合 => 3 errors
  def i18n_error_count(count)
    I18n.locale == :ja ? "#{count}件の#{t('views.common.error')}" : pluralize(count, t('views.common.error'))
  end

  def format_content(content)
    safe_join(content.split("\n"), tag.br)
  end

  def make_mentions(report)
    ReportMention.where(mentioning: report).each(&:destroy)

    report.content.scan(%r{http://localhost:3000/reports/\d+}).each do |url|
      ReportMention.create(mentioning: report, mentioned: Report.find(url.split('/')[-1]))
    end
  end

  def text_t_url(content)
    sanitize(content.gsub(%r{http://localhost:3000/reports/\d+}) { " <a href='#{::Regexp.last_match(0)}' target='_blank'\>#{::Regexp.last_match(0)}</a> " })
  end
end
