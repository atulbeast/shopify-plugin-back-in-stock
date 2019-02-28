class ButtonAddFields < ActiveRecord::Migration[5.2]
  def change
    add_column :buttons, :mail_msg, :string
    add_column :buttons, :text_msg, :string
  end
end
