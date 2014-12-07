class AddRelationToAcknowledgement < ActiveRecord::Migration
  def change
    change_table(:acknowledgements) do |t|
      t.remove :user_id
      t.belongs_to :user
    end
  end
end
