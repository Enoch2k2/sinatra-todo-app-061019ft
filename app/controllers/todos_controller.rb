class TodosController < ApplicationController

  get '/todos' do
    @todos = Todo.all
    erb :'todos/index'
  end

  get '/todos/new' do
    erb :'todos/new'
  end

  get '/todos/:id' do
    set_todo
    erb :'todos/show'
  end

  post '/todos' do
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect '/todos'
    else
      @errors = @todo.errors.full_messages
      erb :'todos/new'
    end
  end

  get '/todos/:id/edit' do
    set_todo
    erb :'todos/edit'
  end

  patch '/todos/:id' do
    set_todo
    if @todo.update(todo_params)
      redirect "/todos/#{@todo.id}"
    else
      @errors = @todo.errors.full_messages
      erb :'todos/edit'
    end
  end

  delete "/todos/:id" do
    set_todo
    @todo.destroy
    redirect "/todos"
  end

  private
    def set_todo
      @todo = Todo.find_by_id(params[:id])
    end

    def todo_params
      { title: params[:todo][:title], completed: params[:todo][:completed] }
    end
end