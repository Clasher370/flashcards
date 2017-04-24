class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string :name, index: true
      t.integer :user_id, index: true, foreign_key: true

      t.timestamps
    end
  end
end
