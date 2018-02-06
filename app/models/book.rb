class Book < ActiveRecord::Base
	has_many :loans
	has_many :borrowers, through: :loans
end 
