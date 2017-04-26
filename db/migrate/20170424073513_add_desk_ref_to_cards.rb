class AddDeskRefToCards < ActiveRecord::Migration[5.0]
  def change
    add_reference :cards, :deck, index: true, foreign_key: true
  end
end
