# frozen_string_literal: true

class AddNoticeToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :notice, :string
  end
end
