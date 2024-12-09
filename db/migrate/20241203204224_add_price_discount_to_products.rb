class AddPriceDiscountToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :discount_price, :float
  end
end
