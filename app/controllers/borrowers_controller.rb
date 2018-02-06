class BorrowersController < ApplicationController
#	get '/borrowers/:slug' do
#		@borrower = Borrower.find_by_slug(params[:slug])
#		erb :'/borrowers/show'
#	end

	get '/borrowers/signup' do
		if logged_in?
			flash[:message] = "You are logged in!"
			redirect "borrowers/#{current_borrower.slug}"
		else 
			erb :"borrowers/new"
		end 
	end

	get '/borrowers' do
		@borrowers = Borrower.all
		erb :"/borrowers/index"
	end

	post '/borrowers' do
		if params[:first_name] == "" || params[:last_name] == "" || params[:email] == ""
			redirect to "borrowers/new"
		else
			@borrower = Borrower.create(params[:borrower])
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
