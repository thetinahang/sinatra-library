require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "password_secret"
        use Rack::Flash 
    end

    get "/" do
        if logged_in?
          redirect "/borrowers/#{current_borrower.slug}"
        else
          erb :index
        end
    end
    
    get '/login' do
        if logged_in?
          flash[:message] = "You are logged in!"
          redirect "/borrowers/#{current_borrower.slug}"
        else
          erb :login
        end
    end
    
    post '/login' do
        borrower = Borrower.find_by(:username => params[:username])
        
        if borrower && borrower.authenticate(params[:password])
          session[:borrower_id] = borrower.id
          flash[:message] = "Welcome, #{borrower.username}!"
          redirect "/borrowers/#{borrower.slug}"
        else
          flash[:message] = "Invalid password/username combination. Please try again."
          redirect '/login'
        end
    end
    
    get '/logout' do
        borrower = current_borrower
        session[:borrower_id] = nil
        flash[:message] = "Goodbye, #{borrower.username}!"
        redirect '/'
    end

    helpers do
        def logged_in?
          !!session[:borrower_id]
        end

        def current_borrower
          borrower.find_by(:id => session[:borrower_id])
        end
    end

end
