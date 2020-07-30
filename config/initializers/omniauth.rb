# frozen_string_literal: true

# OmniAuth initialization

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :facebook,
    Rails.application.credentials.fb[:app_id],
    Rails.application.credentials.fb[:secret],
    image_size: 'normal'
  )
end
