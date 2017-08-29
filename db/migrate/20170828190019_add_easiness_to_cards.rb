#
class AddEasinessToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :easiness, :float, default: 2.5
  end
end
