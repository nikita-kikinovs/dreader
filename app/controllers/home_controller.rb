# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :load_feed

  def feed; end

  private

  def load_feed
    @feed_items = RSS::Parser.parse("https://www.delfi.lv/rss/?channel=#{current_user.channel.code}").items
      .first(current_user.post_count)
  end
end
