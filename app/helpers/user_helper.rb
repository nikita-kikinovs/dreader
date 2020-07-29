module UserHelper
  require 'image_processing/mini_magick'

  def current_user_avatar(options = {})
    klass = options[:class] || 'img-circle'

    image_tag(url_for(current_user.avatar), alt: 'User Avatar', class: klass)
  end

  def current_user_since
    "Member since #{current_user.created_at.to_date}"
  end

  def update_avatar(file, user, skip_resize: false)
    scaled_image = skip_resize ? file : ImageProcessing::MiniMagick.source(file).resize_to_limit!(100, 100)

    user.avatar_updated = true
    user.avatar.attach(io: scaled_image, filename: "user_#{uid}_avatar.jpg")
  end

  def available_channel_list
    html = Nokogiri::HTML(open('https://www.delfi.lv/rss'))

    html.css('.rss-feed-list').css('a').map do |value_arr|
      [value_arr.text, value_arr.values.first.gsub(/.+=/, '')]
    end
  end
end
