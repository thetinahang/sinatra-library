class BooksController < ApplicationController
	get '/books' do
		@books = Book.all
		erb :"/books/index"
	end

	get '/books/new' do
		erb :"books/new"
	end

	post '/books' do
		if params[:title] == "" || params[:author] == "" || params[:isbn] == "" || params[:publisher] == ""
			redirect to "/books/new"
		else
			@book = Book.create(title: params[:title], author: params[:author], isbn: params[:isbn], publisher: params[:publisher])
			redirect to "/books/#{@book.id}"
		end
	end

	get '/books/:id' do 
		@book = Book.find_by_id(params[:id])
		erb :"books/show"
	end

	get '/books/:id/edit' do
		@book = Book.find_by_id(params[:id])
		erb :"books/edit"
	end

	patch '/books/:id' do
		@book = Book.find_by_id(params[:id])
		if params[:title] == "" || params[:author] == "" || params[:isbn] == "" || params[:publisher] == ""
			redirect to "/books/#{params[:id]}/edit"
		else
			@book.title = params[:title]
			@book.author = params[:author]
			@book.isbn = params[:isbn]
			@book.publisher = params[:publisher]
			@book.save
			redirect to "/books"
		end
	end

	post '/books/:id/delete' do
		book = Book.find(params[:id])
		book.delete
		book.save
		redirect to "/books"
	end

end
