class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :customer_key
      t.integer :user_id

      t.timestamps
    end
  end
end
