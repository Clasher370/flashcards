class AddCurrentToDecks < ActiveRecord::Migration[5.0]
  def change
    add_column :decks, :current, :boolean, default: false
  end
end
