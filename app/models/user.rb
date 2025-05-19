# frozen_string_literal: true

class User < ApplicationRecord
  EXTENSIONS = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'].freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validate :avatar_content_type, if: -> { avatar.attached? }

  def avatar_content_type
    errors.add(:avatar, 'に設定できるファイルの拡張子はjpg, png, gifです。') unless avatar.content_type.in?(EXTENSIONS)
  end
end
