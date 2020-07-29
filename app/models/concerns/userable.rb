# frozen_string_literal: true

module Userable
  extend ActiveSupport::Concern
  VALID_CONTENT_TYPES = %w[image/png image/jpeg image/jpg].map(&:freeze)

  def update_avatar(file, user, skip_resize: false)
    if VALID_CONTENT_TYPES.exclude? file.content_type
      user.errors.add(:base, :wrong_attachment_format, message: 'Wrong attachment format')
      throw :abort
    else
      scaled_image = skip_resize ? file : ImageProcessing::MiniMagick.source(file).resize_to_limit!(100, 100)

      user.avatar_updated = true
      user.avatar.attach(io: scaled_image, filename: "user_#{user.uid}_avatar.jpg")

    end
  end
end
