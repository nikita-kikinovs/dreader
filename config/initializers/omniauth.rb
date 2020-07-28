OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '287466899202693', '3d855e77545f8b0ca37a15f027a766e3', image_size: 'normal'
end
