# frozen_string_literal: true

class ChangePhoneNoType < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :phone_no, :string
  end
end
