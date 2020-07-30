# frozen_string_literal: true

class User < ApplicationRecord
  include Userable

  has_one_attached :avatar
  belongs_to :channel, foreign_key: :channel_id

  before_update :set_new_avatar
  before_validation :set_default_channel, if: :new_record?

  validates :name, format: { with: /\A[^0-9`!@#\$%\^&*+_=]+\z/ }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :post_count, numericality: { greater_than_or_equal_to: 0 }
  validates :channel_id, inclusion: { in: Channel.pluck(:id) }

  attr_accessor :new_avatar, :avatar_updated

  # checks if user is present in db, otherwise creates new user using received data
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

  # callback method that sets new user avatar
  def set_new_avatar
    return if new_avatar.blank? || avatar_updated

    update_avatar(new_avatar, self)
  end

  # callback method that sets user default channel on create
  def set_default_channel
    self.channel = Channel.default_channel
  end
end

# == Schema Information
#
# Table name: users
#
#  id                                                    :bigint           not null, primary key
#  provider(authorization provider name)                 :string           not null
#  uid(user id provided by authorization provider)       :string           not null
#  name(user name)                                       :string           not null
#  email(user email)                                     :string           not null
#  channel_id(preferred delfi rss channel)               :integer          not null
#  post_count(preferred feed post count)                 :integer          default(10), not null
#  oauth_token(authorization token)                      :string           not null
#  oauth_expires_at(authorization token expiration time) :datetime         not null
#  created_at                                            :datetime         not null
#  updated_at                                            :datetime         not null
#
