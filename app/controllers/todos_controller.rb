class TodosController < ApplicationController
  use Rack::Flash

  get '/todos' do
    redirect_if_not_signed_in
    @todos = current_user.todos
    erb :'todos/index'
  end

  get '/todos/new' do
    redirect_if_not_signed_in
    erb :'todos/new'
  end

  get '/todos/:id' do
    redirect_if_not_signed_in
    set_todo
    erb :'todos/show'
  end

  post '/todos' do
    redirect_if_not_signed_in
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      redirect '/todos'
    else
      @errors = @todo.errors.full_messages
      erb :'todos/new'
    end
  end

  get '/todos/:id/edit' do
    redirect_if_not_signed_in
    set_todo
    if @todo.user == current_user
      erb :'todos/edit'
    else
      flash[:notice] = "You are not authorized to do that."
      redirect '/'
    end
  end

  patch '/todos/:id' do
    redirect_if_not_signed_in
    set_todo
    if @todo.update(todo_params)
      redirect "/todos/#{@todo.id}"
    else
      @errors = @todo.errors.full_messages
      erb :'todos/edit'
    end
  end

  delete "/todos/:id" do
    redirect_if_not_signed_in
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