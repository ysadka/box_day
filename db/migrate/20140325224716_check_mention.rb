class CheckMention < ActiveRecord::Migration
  def change
    add_column :tweets, :iron_mention, :boolean, default: true
  end
end
