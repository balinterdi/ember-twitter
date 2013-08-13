class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :name
      t.text   :oauth_token
      t.text   :oauth_token_secret
      t.text   :avatar_url
      t.text   :location
      t.text   :website
      t.text   :description

      t.timestamps
    end
  end
end
