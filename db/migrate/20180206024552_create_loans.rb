class CreateLoans < ActiveRecord::Migration[5.1]
  def change
  	create_table :loans do |t|
  		t.string :borrowed_date
  		t.string :return_date 
  		t.integer :book_id
  		t.integer :user_id

  		t.timestamps null: false
  	end 
  end
end
