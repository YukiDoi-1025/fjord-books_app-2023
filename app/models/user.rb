# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validate :avatar_content_type, if: :was_attached?

  def avatar_content_type
    extension = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
    errors.add(:avatar, 'に設定できるファイルの拡張子はjpg, png, gifです。') unless avatar.content_type.in?(extension)
  end

  def was_attached?
    avatar.attached?
  end
end
