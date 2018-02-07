class BorrowersController < ApplicationController
#	get '/borrowers/:slug' do
#		@borrower = Borrower.find_by_slug(params[:slug])
#		erb :'/borrowers/show'
#	end

	get '/borrowers/signup' do
		if logged_in?
			flash[:message] = "You are already logged in!"
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
		if params[:username] == "" || params[:email] == "" || params[:password] = "" 
			redirect to "borrowers/new"
		else
			@borrower = Borrower.create(params[:borrower])
			@borrower.save
			redirect to "/borrowers"
		end
	end

	get '/borrowers/:id' do 
		@borrower = Borrower.find(params[:id])
		erb :"borrowers/show"
	end

end
