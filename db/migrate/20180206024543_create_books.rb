class CreateBooks < ActiveRecord::Migration[5.1]
  def change
  	create_table :books do |t|
  		t.string :title
  		t.string :author
  		t.string :isbn
  		t.string :publisher 

  		t.timestamps null: false
  	end 
  end
end
