class LoansController < ApplicationController
	get '/loans' do
		@loans = Loan.all
		erb :"/loans/loans"
	end

	get '/loans/new' do
		erb :"loans/new"
	end

	post '/loans' do
		if params[:title] == "" || params[:author] == "" || params[:isbn] == "" || params[:publisher] == ""
			redirect to "/loans/new"
		else
			@loan = Loan.create(title: params[:title], author: params[:author], isbn: params[:isbn], publisher: params[:publisher])
			redirect to "/loans/#{@loan.id}"
		end
	end

	get '/loans/:id' do 
		@loan = Loan.find(params[:id])
		erb :"loans/show"
	end

	get '/loans/:id/edit' do
		@loan = loan.find(params[:id])
		erb :"loans/edit"
	end

	patch '/loans/:id' do
		@loan = Loan.find_by_id(params[:id])
		if params[:title] == "" || params[:author] == "" || params[:isbn] == "" || params[:publisher] == ""
			redirect to "/loans/#{params[:id]}/edit"
		else
			@loan.title = params[:title]
			@loan.author = params[:author]
			@loan.isbn = params[:isbn]
			@loan.publisher = params[:publisher]
			@loan.save
			redirect to "/loans"
		end
	end

	post '/loans/:id/delete' do
		loan = Loan.find(params[:id])
		loan.delete
		loan.save
		redirect to "/loans"
	end

end
