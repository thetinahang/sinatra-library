class Borrower < ActiveRecord::Base
	has_many :loans
	has_many :books, through: :loans
	
	def slug
		self.username.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)
		Borrower.all.find{|borrower| borrower.slug == slug}
	end

end
