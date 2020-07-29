class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :provider, null: false, comment: 'authorization provider name'
      t.string :uid, null: false, comment: 'user id provided by authorization provider'
      t.string :name, null: false, comment: 'user name'
      t.string :email, null: false, comment: 'user email'
      t.string :channel_id, null: false, comment: 'preferred delfi rss channel'
      t.string :post_count, default: 10, null: false, comment: 'preferred feed post count'
      t.string :oauth_token, null: false, comment: 'authorization token'
      t.datetime :oauth_expires_at, null: false

      t.timestamps
    end
  end
end
