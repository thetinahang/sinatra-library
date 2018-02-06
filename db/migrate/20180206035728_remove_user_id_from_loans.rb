class RemoveUserIdFromLoans < ActiveRecord::Migration[5.1]
  def change
  	remove_column :loans, :user_id
  end
end
