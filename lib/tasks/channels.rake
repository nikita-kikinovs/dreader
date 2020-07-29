namespace :channels do
  desc 'fetch delfi rss channels'

  task fetch: :environment do
    html = Nokogiri::HTML(open('https://www.delfi.lv/rss'))

    # create existing delfi rss feed code and name map
    channels = html.css('.rss-feed-list').css('a').each_with_object({}) do |value_arr, a|
      a[value_arr.values.first.gsub(/.+=/, '')] = value_arr.text
    end

    # figure out outdated/new rss feed codes
    current_codes = Channel.pluck(:code)
    removable_codes = current_codes - channels.keys
    new_codes = channels.keys - current_codes

    # users who have outdated channels will now have default channel
    User.includes(:channel).where(channels: { code: removable_codes })
      .update_all(channel_id: Channel.default_channel.id)

    # remove outdated channels
    Channel.where(code: removable_codes).destroy_all

    # add new channels
    new_codes.each do |new_code|
      Channel.create(code: new_code, name: channels[new_code])
    end

    puts "\n--- DELFI RSS Feed channels successfully updated!"
    puts "  * Deleted #{removable_codes.count} channels"
    puts "  * Created #{new_codes.count} channels"
  end
end
