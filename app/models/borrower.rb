class Borrower < ActiveRecord::Base
	has_many :loans
	has_many :books, through: :loans
	
	def slug
		self.username.downcase.gsub(" ", "-")
	end

	def self.find_by_slug(slug)
		User.all.find{|user| user.slug == slug}
	end

end
