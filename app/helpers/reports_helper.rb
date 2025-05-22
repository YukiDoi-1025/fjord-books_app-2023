# frozen_string_literal: true

module ReportsHelper
  def make_mentions(report)
    ReportMention.where(mentioning: report).each(&:destroy)

    report.content.scan(%r{http://localhost:3000/reports/\d+}).each do |url|
      logger.debug(report)
      logger.debug(url)
      ReportMention.create(mentioning: report, mentioned: Report.find(url.split('/')[-1]))
      logger.debug('作成')
      logger.debug(ReportMention.where(mentioning: report).each(&:inspect))
    end
  end
end
