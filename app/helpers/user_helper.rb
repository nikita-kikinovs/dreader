# frozen_string_literal: true

module UserHelper
  require 'image_processing/mini_magick'

  def current_user_avatar(options = {})
    klass = options[:class] || 'img-circle'

    image_tag(url_for(current_user.avatar), alt: 'User Avatar', class: klass)
  end

  def current_user_since
    "Member since #{current_user.created_at.to_date}"
  end

  def max_post_count
    "Showing #{current_user.post_count} posts max"
  end
end
