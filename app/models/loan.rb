class Loan < ActiveRecord::Base 
	belongs_to :borrower
	belongs_to :book 
end 