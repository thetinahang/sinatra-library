class BorrowersController < ApplicationController
	get '/borrowers' do
		@borrowers = Borrower.all
		erb :"/borrowers/borrowers"
	end

#	get '/borrowers/:slug' do
#		@borrower = Borrower.find_by_slug(params[:slug])
#		erb :'/borrowers/show'
#	end

	get '/borrower_form' do
		@books = Book.all
		erb :"borrowers/create_borrower"
	end

	post '/borrower_form' do
		if params[:first_name] == "" || params[:last_name] == "" || params[:email] == ""
			redirect to "/borrower_form"
		else
			@borrower = Borrower.create(params[:borrower])
			if !params[:book].empty?
  				@borrower.books << Book.create(params[:book])
			end
			@borrower.save
			redirect to "/borrowers"
		end
	end

	get '/borrowers/:id' do 
		@borrower = Borrower.find(params[:id])
		erb :"borrowers/show_borrower"
	end

	get '/borrowers/:id/edit' do
		@borrower = Borrower.find(params[:id])
		erb :"borrowers/edit_borrower"
	end

	patch '/borrowers/:id' do
		@borrower = Borrower.find_by_id(params[:id])
		if params[:first_name] == "" || params[:last_name] == "" || params[:email] == "" 
			redirect to "/borrowers/#{params[:id]}/edit"
		else
			@borrower.first_name = params[:first_name]
			@borrower.last_name = params[:last_name]
			@borrower.email = params[:email]
			@borrower.save
			redirect to "/borrowers"
		end
	end

	post '/borrowers/:id/delete' do
		borrower = Borrower.find(params[:id])
		borrower.delete
		borrower.save
		redirect to "/borrowers"
	end

end
