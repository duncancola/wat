class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.boolean :has_ended, :default => false

      t.timestamps
    end
  end
end
