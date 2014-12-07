class AddClientTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :client_token, :string
  end
end
