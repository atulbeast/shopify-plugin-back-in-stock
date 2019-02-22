class CreateButtons < ActiveRecord::Migration[5.2]
  def change
    create_table :buttons do |t|
      t.string :button_name
      t.string :notify_message
      t.string :form_title
      t.references :shop, :buttons, index:false
      t.timestamps
    end
  end
end
