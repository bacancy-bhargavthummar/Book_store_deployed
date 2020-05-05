class AddDeliveryAddressToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :delivery_address, :string
  end
end
