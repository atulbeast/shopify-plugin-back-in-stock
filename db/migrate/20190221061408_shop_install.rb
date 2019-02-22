class ShopInstall < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :install, :boolean
  end
end
