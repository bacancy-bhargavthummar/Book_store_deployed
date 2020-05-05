# frozen_string_literal: true

class AddApprovalToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :approval, :integer, default: 0
  end
end
