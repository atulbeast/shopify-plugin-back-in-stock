class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :email
      t.string :contact
      t.references :account, :shop
      t.timestamps
    end
  end
end
