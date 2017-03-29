class AddUniqueIndexToCards < ActiveRecord::Migration[5.0]
  def change
    add_index :cards, [:original_text, :translated_text], unique: true
  end
end
