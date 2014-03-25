class AddAttaachedPhotoToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :attached_photo, :string
  end
end
