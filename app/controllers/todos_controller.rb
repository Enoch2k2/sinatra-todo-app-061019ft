class TodosController < ApplicationController

  get '/todos' do
    @todos = Todo.all
    erb :'todos/index'
  end

  get '/todos/new' do
    erb :'todos/new'
  end

  get '/todos/:id' do
    @todo = Todo.find_by_id(params[:id])
    erb :'todos/show'
  end

  post '/todos' do
    todo = Todo.create(params)
    redirect '/todos'
  end

end