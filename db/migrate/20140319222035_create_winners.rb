class CreateWinners < ActiveRecord::Migration
  def change
    create_join_table :prizes, :tweets, table_name: :winners do |t|
      t.index :tweet_id
      t.index :prize_id

      t.timestamps
    end
  end
end
