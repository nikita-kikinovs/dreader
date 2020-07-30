# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :load_feed

  # renders main page with feed
  def feed; end

  private

  # sets instance variable with rss feed records received from specific url limited to preferred count
  def load_feed
    @feed_items = RSS::Parser.parse("https://www.delfi.lv/rss/?channel=#{current_user.channel.code}").items
      .first(current_user.post_count)
  end
end
