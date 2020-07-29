class User < ApplicationRecord
  include UserHelper
  require 'open-uri'

  has_one_attached :avatar
  has_one :channel

  before_save :set_new_avatar, :set_default_channel

  validates :name, format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :post_count, numericality: true

  attr_accessor :new_avatar, :avatar_updated

  def self.from_omniauth(auth)
    where(provider: auth[:provider], uid: auth[:uid]).first_or_initialize.tap do |user|
      if user.new_record?
        user.name = auth.info.name
        user.email = auth.info.email
        user.provider = auth.provider
        user.uid = auth.uid
        user.update_avatar(open(auth.info.image), user, skip_resize: true)
      end

      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)

      user.save!
    end
  end

  private

  def set_new_avatar
    return if new_avatar.blank? || avatar_updated

    update_avatar(new_avatar, self)
  end

  def set_default_channel
    return unless new_record?

    self.channel = Channel.find_by(code: 'delfi')
  end
end

# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  provider         :string
#  uid              :string
#  name             :string
#  email            :string
#  channel          :string           default("delfi")
#  post_count       :string           default("10")
#  oauth_token      :string
#  oauth_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
