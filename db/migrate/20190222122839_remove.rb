class Remove < ActiveRecord::Migration[5.2]
  def change
    remove_column :buttons,:buttons_id
  end
end
