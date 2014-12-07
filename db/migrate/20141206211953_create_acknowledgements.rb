class CreateAcknowledgements < ActiveRecord::Migration
  def change
    create_table :acknowledgements do |t|
      t.string :ip_address
      t.integer :user_id

      t.timestamps
    end
  end
end
