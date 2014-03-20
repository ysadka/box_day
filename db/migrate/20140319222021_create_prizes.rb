class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
      t.string  :name,     null: false
      t.integer :event_id, null: false

      t.timestamps
    end
  end
end
