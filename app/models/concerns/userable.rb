# frozen_string_literal: true

module Userable
  extend ActiveSupport::Concern
  VALID_CONTENT_TYPES = %w[image/png image/jpeg image/jpg].map(&:freeze)

  # updates user avatar if received image file has valid format,
  # otherwise adds error to user object and aborts user object saving process
  # before attaching if skip_resize is false resizes image uploaded by user to 100x100 pixels
  # sets avatar_updated flag to true so that callback does not result in endless loop (attach method is calling save)
  def update_avatar(file, user, skip_resize: false)
    if VALID_CONTENT_TYPES.exclude? file.content_type
      user.errors.add(:base, :wrong_attachment_format, message: 'Wrong attachment format')
      throw :abort
    else
      scaled_image = skip_resize ? file : ImageProcessing::MiniMagick.source(file).resize_to_fit!(100, nil)

      user.avatar_updated = true
      user.avatar.attach(io: scaled_image, filename: "user_#{user.uid}_avatar.jpg")
    end
  end
end
