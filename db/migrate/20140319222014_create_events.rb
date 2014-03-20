class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false, default: ''
      t.date   :date, null: false

      t.timestamps
    end
  end
end
