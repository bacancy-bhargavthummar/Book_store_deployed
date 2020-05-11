class AddRatingToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :rating, :float
  end
end
