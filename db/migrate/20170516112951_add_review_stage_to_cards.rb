class AddReviewStageToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :review_stage, :string
  end
end
