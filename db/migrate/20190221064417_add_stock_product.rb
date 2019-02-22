class AddStockProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :variant_id, :string
    add_column :accounts, :product, :string
  end
end
