# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentioning_relationships, class_name: 'ReportMention',
                                      foreign_key: :mentioning_id,
                                      dependent: :destroy,
                                      inverse_of: :mentioning
  has_many :mentioning_reports, through: :mentioning_relationships, source: :mentioned

  has_many :mentioned_relationships, class_name: 'ReportMention',
                                     foreign_key: :mentioned_id,
                                     dependent: :destroy,
                                     inverse_of: :mentioned
  has_many :mentioned_reports, through: :mentioned_relationships, source: :mentioning

  validates :title, presence: true
  validates :content, presence: true

  after_save :make_mentions

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def make_mentions
    mentioning_relationships.destroy_all
    content.scan(%r{http://localhost:3000/reports/\d+}).each do |url|
      mentioned_id = url.split('/')[-1]
      ReportMention.create(mentioning_id: id, mentioned_id:)
    end
  end
end
