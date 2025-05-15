# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :user_id, presence: true
  validates :article, presence: true

  belongs_to :user
  belongs_to :commentable, polymorphic: true
end
