class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string  :body,     null: false, default: ''
      t.boolean :replied,  null: false, default: false
      t.string  :username, null: false, default: ''

      t.timestamps
    end
  end
end
