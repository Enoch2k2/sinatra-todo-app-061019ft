class SessionsController < ApplicationController
  use Rack::Flash

  get '/signup' do
    erb :'sessions/signup'
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      # log in user via cookie in browser
      session[:user_id] = user.id
      # temporary message to be shown in the welcome page
      flash[:notice] = "Successfully signed in."
      redirect '/'
    else
      @errors = user.errors.full_messages
      erb :'sessions/signup'
    end
  end
  
  get '/login' do
    erb :'sessions/login'
  end
  
  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Successfully signed in."
      redirect '/'
    else
      @errors = ["Username or password did not match"]
      erb :'sessions/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end