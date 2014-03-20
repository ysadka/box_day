class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username,     null: false, default: ''
      t.string :provider,     null: false, default: ''
      t.string :uid,          null: false, default: ''
      t.string :oauth_token,  null: false, default: ''
      t.string :oauth_secret, null: false, default: ''

      t.timestamps
    end
  end
end
