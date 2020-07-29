# frozen_string_literal: true

class Channel < ApplicationRecord
  DEFAULT_CHANNEL = 'delfi'

  def self.default_channel
    find_by(code: DEFAULT_CHANNEL)
  end
end

# == Schema Information
#
# Table name: channels
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
