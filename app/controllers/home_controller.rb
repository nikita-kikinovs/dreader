class HomeController < ApplicationController
  before_action :load_feed

  def feed; end

  private

  def load_feed
    @feed = RSS::Parser.parse("https://www.delfi.lv/rss/?channel=#{current_user.channel}")
  end
end
